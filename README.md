# NixOS configuration — host `athena`

Flake-based NixOS configuration for the laptop `athena` (Intel, NVMe, 16 GiB RAM,
TPM 2.0 / Intel PTT). It is a modular configuration built on `nixos-unstable`,
with system modules under `modules/system/`, home-manager modules under
`modules/home/`, and per-host configuration under `hosts/athena/`.

## What this configuration provides

- **Declarative partitioning with [disko](https://github.com/nix-community/disko)** —
  the full disk layout is defined in code: GPT → 1 GiB ESP → LUKS2 → LVM → btrfs
  subvolumes (`/`, `/nix`, `/home`) plus a 20 GiB encrypted swap volume for
  hibernation.
- **Secure Boot via [lanzaboote](https://github.com/nix-community/lanzaboote)** —
  replaces systemd-boot and signs the boot chain with your own keys (enrolled
  alongside Microsoft's keys so pre-signed firmware option ROMs keep working).
- **TPM2 + optional FIDO2 LUKS auto-unlock** — the disk unlocks automatically on a
  trusted boot (TPM2 bound to PCR 7), with an optional FIDO2 security key and a
  permanent passphrase fallback.

---

## ⚠️ Critical ordering

Read this before setting up the encryption and boot features. The order is
load-bearing:

1. **Install → first boot (systemd-boot) → Secure Boot → THEN TPM2 enrollment.**
2. **TPM2 enrollment must come AFTER Secure Boot is active.** PCR 7 reflects the
   Secure Boot state and your enrolled keys. Enrolling the TPM against PCR 7
   before Secure Boot is on binds the disk to a value that will change, so
   auto-unlock will silently fail once you enable Secure Boot.
3. **Never enable TPM auto-unlock while Secure Boot is off.** Without Secure Boot
   a tampered kernel/initrd can still satisfy PCR 7 and obtain the key.
4. **Never remove the passphrase keyslot.** It is your permanent fallback. Do NOT
   run `systemd-cryptenroll --wipe-slot=password`.

---

## Before you start

### Firmware / BIOS preparation

- Enter firmware setup and **enable the TPM** (Intel PTT / fTPM — usually under
  *Security*).
- Confirm you can **put Secure Boot into Setup Mode** (clear / delete the Platform
  Key) and later **enable Secure Boot** (menu names vary by vendor, typically
  under *Security* or *Boot*). You can leave Secure Boot **off** for the initial
  install.
- Boot the NixOS installer in **UEFI mode**.

### Confirm the target disk

disko **will destroy the target disk**. Before formatting, confirm the NVMe
device path and the LUKS partition number:

```bash
lsblk -f
```

- The disk is typically `/dev/nvme0n1` (set in `hosts/athena/disko.nix`; a
  `# VERIFY with lsblk` comment marks the line). **Update it if your installer
  reports a different path.**
- After formatting, the LUKS partition shows up as type `crypto_LUKS` — it is the
  GPT partition backing the container, e.g. `/dev/nvme0n1p2`. You need this path
  for TPM/FIDO2 enrollment later.

> **Placeholders you must fill in:**
> - `<DISK>` — the real NVMe disk path, e.g. `/dev/nvme0n1` (from `lsblk -f`).
> - `<LUKS-PART>` — the LUKS partition path, e.g. `/dev/nvme0n1p2`
>   (the `crypto_LUKS` entry in `lsblk -f`).
> - `<CONFIG>` — path to this configuration during install, e.g.
>   `/mnt/etc/nixos` or a temp clone.

---

## Install steps

Nine ordered steps. Do them in order.

> **Scripted path:** `install.sh` automates the parts that are safe to automate
> and stops at every manual firmware/reboot boundary. It runs in three phases
> that map onto the steps below:
>
> ```bash
> sudo ./install.sh install    <DISK> <CONFIG>   # steps 2–4
> sudo ./install.sh secureboot                   # step 6 (automatable part)
> sudo ./install.sh tpm        <LUKS-PART>        # step 8
> ```
>
> The script handles the `secureboot.nix` toggle for you (comments it out for
> the first install, re-enables it in the `secureboot` phase) and the two-build
> `sbctl` sequence. It will **not** touch firmware, reboot, or enroll Secure Boot
> keys — do those manual steps (6e–6g, the reboots, and all verification) from
> the runbook below. Read the "Critical ordering" section first either way.

### 1. Boot the installer

Boot the NixOS installer in UEFI mode. In firmware: TPM/PTT enabled, Secure Boot
can be set to Setup Mode later (leave it off for now).

### 2. Prepare the configuration

Make this configuration available on the installer (clone it, or mount a copy).
Verify the disk path in `hosts/athena/disko.nix` matches `lsblk`.

Leave Secure Boot **disabled for the first install** so the first boot runs on
systemd-boot. The committed `hosts/athena/configuration.nix` ships with
`secureboot.nix` **imported** (that is the steady state after setup), so before
the first install you must comment that import out:

```nix
    # ../../modules/system/secureboot.nix  # ENABLE AT RUNBOOK STEP 6
```

The `install install` phase of `install.sh` does this automatically; if you are
installing by hand, edit the line yourself. You re-enable it at step 6.
`luks-unlock.nix` is imported from the start; it is safe and independent of
Secure Boot.

### 3. Partition + format + mount with disko

This **prompts for the LUKS passphrase** — that passphrase becomes the permanent
fallback keyslot.

```bash
sudo nix run github:nix-community/disko/latest -- \
  --mode destroy,format,mount \
  --flake <CONFIG>#athena \
  --yes-wipe-all-disks
```

Everything is now mounted under `/mnt`. Generate the hardware file **without**
filesystem stanzas (disko owns them):

```bash
sudo nixos-generate-config --no-filesystems --root /mnt
```

The committed `hardware-configuration.nix` already has the disko-managed
`fileSystems.*`, `boot.initrd.luks`, and `swapDevices` stanzas removed; if the
generator re-adds anything, reconcile so only the kernel-module / microcode /
`hostPlatform` lines remain.

### 4. Install

```bash
sudo nixos-install --flake <CONFIG>#athena
```

Set root and user passwords when prompted. Reboot.

### 5. First boot on systemd-boot

Log in. You will be prompted for the **LUKS passphrase** (no TPM yet). Confirm:

```bash
swapon --show        # swap volume is active
systemctl hibernate  # then power on and confirm resume works
```

### 6. Set up Secure Boot (lanzaboote)

a. Re-enable the Secure Boot module — in `hosts/athena/configuration.nix`,
uncomment the import you commented out at step 2:

```nix
    ../../modules/system/secureboot.nix
```

This forces systemd-boot off (`lib.mkForce false`) and switches to lanzaboote.
(`sudo ./install.sh secureboot` does this and steps 6b–6d for you.)

b. Rebuild to activate the module. This puts `sbctl` on your `PATH` (it is
installed by `secureboot.nix`) and switches the loader to lanzaboote:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#athena
```

c. Create your Secure Boot keys (written to `/var/lib/sbctl`):

```bash
sudo sbctl create-keys
```

d. Rebuild again so lanzaboote signs the boot chain with the keys you just
created:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#athena
```

e. Reboot into firmware, put Secure Boot into **Setup Mode** (clear the Platform
Key), save and return to NixOS.

f. Enroll your keys **together with Microsoft's keys** (recommended):

```bash
sudo sbctl enroll-keys --microsoft
```

Recent `sbctl` warns if you enroll without the Microsoft keys, because much
firmware ships option ROMs (some GPUs, Thunderbolt, NICs) that are Microsoft-
signed; without those keys that code fails verification and the machine can fail
to boot. Enrolling `--microsoft` still installs *your* keys and signs the boot
chain with them — you are only additionally trusting Microsoft's keys so pre-
signed option ROMs keep working.

```bash
#   Own-keys-only (no Microsoft trust anchor) — only if you have confirmed your
#   firmware has no Microsoft-signed option ROMs. Reversible: clear back to
#   Setup Mode and re-run with --microsoft if the machine fails to boot.
#   sudo sbctl enroll-keys
```

g. Reboot into firmware, **enable Secure Boot**, save and return to NixOS.

### 7. Verify Secure Boot

```bash
bootctl status   # should report: Secure Boot: enabled (user)
sbctl verify     # all boot files signed except the raw bzImage (expected)
sbctl status     # Setup Mode: Disabled, Secure Boot: Enabled
```

The raw `…-bzImage.efi` showing as *not signed* is expected — the signed
artifacts are the UKIs / `BOOTX64.EFI` / `systemd-bootx64.efi`.

### 8. Enroll TPM2 against PCR 7 (last)

Only now that Secure Boot is active (PCR 7 is final):

```bash
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 <LUKS-PART>
#   (prompts for your existing passphrase to authorize the new keyslot)
```

Optionally enroll a FIDO2 security key (can be done at any time, independent of
PCR state — set a FIDO2 PIN first if the key does not have one):

```bash
sudo systemd-cryptenroll --fido2-device=auto <LUKS-PART>
```

Inspect the enrolled keyslots (expect `password` + `tpm2` [+ `fido2`]):

```bash
sudo systemd-cryptenroll <LUKS-PART>
```

**Keep the passphrase slot. Never run `--wipe-slot=password`.**

### 9. Test auto-unlock and fallbacks

- Reboot — on a trusted boot the disk should unlock **with no prompt**.
- Confirm the **passphrase** still works (your lifeline — always verify it).
- If enrolled, confirm the **FIDO2** key works.
- Re-test **hibernate / resume** now that TPM unlock is in play.

---

## Keyslots summary

| Keyslot            | Role                          | Notes                                            |
|--------------------|-------------------------------|--------------------------------------------------|
| Passphrase         | Permanent fallback            | Created by disko at format. **Never remove.**    |
| TPM2 (PCR 7)       | Automatic unlock              | Enrolled last, after Secure Boot is active.      |
| FIDO2 (optional)   | Portable secondary method     | Independent of PCR state; enroll any time.       |

At boot, the systemd initrd tries the TPM first; if PCR 7 does not match it falls
back to prompting, where you can insert the FIDO2 key or type the passphrase.

---

## Troubleshooting

- **Auto-unlock fails / disk prompts for a passphrase:** this is the graceful
  fallback. PCR 7 changed (firmware or Secure Boot key change) or the TPM is in a
  different state. Type the passphrase to get in, then re-establish auto-unlock:

  ```bash
  sudo systemd-cryptenroll --wipe-slot=tpm2 <LUKS-PART>
  sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 <LUKS-PART>
  ```

  Re-enroll the TPM any time you re-enroll Secure Boot keys (which changes PCR 7)
  or clear the TPM.
- **`sbctl verify` shows the raw bzImage unsigned:** expected, not an error (see
  step 7).
- **FIDO2 touch prompt not visible behind Plymouth:** press Esc to drop the
  splash. Cosmetic; it does not block unlocking.
