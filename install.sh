#!/usr/bin/env bash
#
# Phased install helper for host `athena`.
#
# This script automates ONLY the steps that are safe to automate. Everything
# involving firmware/BIOS (Secure Boot Setup Mode, enabling Secure Boot),
# reboots, and interactive password/passphrase prompts stays manual — the
# script stops at those boundaries and tells you which README step to do next.
#
# Read the README's "Critical ordering" section before running anything. The
# phase order is load-bearing:
#
#   install  → (reboot, firmware)  → secureboot → (firmware + enroll, manual)
#            → (reboot)            → tpm         → (reboot, verify)
#
# Usage:
#   sudo ./install.sh install    <DISK> <CONFIG>     # README steps 2–4
#   sudo ./install.sh secureboot                     # README step 6 (automatable part)
#   sudo ./install.sh tpm        <LUKS-PART>         # README step 8
#
# Arguments:
#   <DISK>      NVMe disk path, e.g. /dev/nvme0n1   (confirm with `lsblk -f`)
#   <CONFIG>    path to this config during install, e.g. /mnt/etc/nixos
#   <LUKS-PART> LUKS partition, e.g. /dev/nvme0n1p2 (the crypto_LUKS entry in `lsblk -f`)

set -euo pipefail

FLAKE_HOST="athena"
SECUREBOOT_LINE="../../modules/system/secureboot.nix"

# Resolve the directory this script lives in, so it works regardless of cwd.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_NIX="hosts/athena/configuration.nix"

err()  { printf '\033[31merror:\033[0m %s\n' "$*" >&2; }
info() { printf '\033[36m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[33mwarning:\033[0m %s\n' "$*" >&2; }

require_root() {
  if [[ "${EUID}" -ne 0 ]]; then
    err "this phase must be run as root (use sudo)."
    exit 1
  fi
}

confirm() {
  local prompt="$1"
  local reply
  read -r -p "${prompt} [y/N] " reply
  [[ "${reply}" == "y" || "${reply}" == "Y" ]]
}

# Comment out the secureboot.nix import (install-time baseline: systemd-boot).
comment_secureboot() {
  local file="$1"
  if grep -qE "^\s*#\s*${SECUREBOOT_LINE//\//\\/}" "${file}"; then
    info "secureboot.nix is already commented out."
    return
  fi
  # Prefix the (uncommented) import line with "# ".
  sed -i -E "s|^(\s*)(${SECUREBOOT_LINE//\//\\/}.*)$|\1# \2|" "${file}"
  info "Commented out secureboot.nix for the first install (systemd-boot baseline)."
}

# Uncomment the secureboot.nix import (step 6: switch to lanzaboote).
uncomment_secureboot() {
  local file="$1"
  if grep -qE "^\s*${SECUREBOOT_LINE//\//\\/}" "${file}"; then
    info "secureboot.nix is already enabled."
    return
  fi
  sed -i -E "s|^(\s*)#\s*(${SECUREBOOT_LINE//\//\\/}.*)$|\1\2|" "${file}"
  info "Enabled secureboot.nix (lanzaboote)."
}

phase_install() {
  require_root
  local disk="${1:-}" config="${2:-}"
  if [[ -z "${disk}" || -z "${config}" ]]; then
    err "usage: sudo ./install.sh install <DISK> <CONFIG>"
    exit 1
  fi
  if [[ ! -b "${disk}" ]]; then
    err "<DISK> '${disk}' is not a block device. Confirm with 'lsblk -f'."
    exit 1
  fi
  local config_nix="${config%/}/${CONFIG_NIX}"
  if [[ ! -f "${config_nix}" ]]; then
    err "cannot find ${config_nix}. Is <CONFIG> the root of this configuration?"
    exit 1
  fi

  warn "disko will DESTROY all data on ${disk}."
  lsblk -f "${disk}" || true
  if ! confirm "Erase ${disk} and install ${FLAKE_HOST}?"; then
    info "Aborted. Nothing was changed."
    exit 0
  fi

  # Baseline for first boot must be systemd-boot, not lanzaboote.
  comment_secureboot "${config_nix}"

  info "Partitioning, formatting, and mounting with disko (prompts for LUKS passphrase)..."
  nix run github:nix-community/disko/latest -- \
    --mode destroy,format,mount \
    --flake "${config}#${FLAKE_HOST}" \
    --yes-wipe-all-disks

  info "Generating hardware config without filesystem stanzas (disko owns them)..."
  nixos-generate-config --no-filesystems --root /mnt

  warn "If the generator re-added fileSystems/luks/swapDevices stanzas, reconcile"
  warn "hardware-configuration.nix so only kernel-module / microcode / hostPlatform remain."

  info "Installing NixOS (prompts for root + user passwords)..."
  nixos-install --flake "${config}#${FLAKE_HOST}"

  cat <<'NEXT'

install phase complete.
  Next (manual): reboot. On first boot you unlock with the LUKS passphrase
  (no TPM yet). Verify swap + hibernate per README step 5. Then run:

      sudo ./install.sh secureboot

NEXT
}

phase_secureboot() {
  require_root
  local config_nix="${SCRIPT_DIR}/${CONFIG_NIX}"
  if [[ ! -f "${config_nix}" ]]; then
    err "cannot find ${config_nix}. Run this from the installed system's /etc/nixos."
    exit 1
  fi

  # Step 6a: enable the module.
  uncomment_secureboot "${config_nix}"

  # Step 6b: rebuild to activate the module (puts sbctl on PATH, switches to lanzaboote).
  info "Rebuild #1: activating secureboot.nix (installs sbctl, switches to lanzaboote)..."
  nixos-rebuild switch --flake "${SCRIPT_DIR}#${FLAKE_HOST}"

  # Step 6c: create keys now that sbctl exists.
  if [[ -f /var/lib/sbctl/keys/db/db.key ]]; then
    info "Secure Boot keys already exist in /var/lib/sbctl; skipping create-keys."
  else
    info "Creating Secure Boot keys in /var/lib/sbctl..."
    sbctl create-keys
  fi

  # Step 6d: rebuild again so lanzaboote signs the boot chain with those keys.
  info "Rebuild #2: signing the boot chain with your keys..."
  nixos-rebuild switch --flake "${SCRIPT_DIR}#${FLAKE_HOST}"

  cat <<'NEXT'

secureboot phase complete (keys created, boot chain signed).
  Next steps are MANUAL (firmware + reboots) — see README step 6e–6g:
    1. Reboot into firmware, put Secure Boot into Setup Mode (clear the PK).
    2. Back in NixOS, enroll keys (recommended, keeps firmware option ROMs working):

           sudo sbctl enroll-keys --microsoft

    3. Reboot into firmware, ENABLE Secure Boot, save, return to NixOS.
    4. Verify (README step 7):  bootctl status ; sbctl verify ; sbctl status

  Only after Secure Boot is ENABLED and verified, run:

      sudo ./install.sh tpm <LUKS-PART>

NEXT
}

phase_tpm() {
  require_root
  local luks="${1:-}"
  if [[ -z "${luks}" ]]; then
    err "usage: sudo ./install.sh tpm <LUKS-PART>"
    exit 1
  fi
  if [[ ! -e "${luks}" ]]; then
    err "<LUKS-PART> '${luks}' does not exist. Find the crypto_LUKS entry in 'lsblk -f'."
    exit 1
  fi

  # Guard: PCR 7 is only final once Secure Boot is actually enabled.
  if command -v bootctl >/dev/null 2>&1; then
    if ! bootctl status 2>/dev/null | grep -qiE "Secure Boot:\s*enabled"; then
      err "Secure Boot does not report as enabled. Enrolling the TPM now would bind"
      err "to a PCR 7 value that changes once Secure Boot turns on — auto-unlock would"
      err "silently fail. Complete README steps 6–7 first."
      exit 1
    fi
  else
    warn "bootctl not found; cannot confirm Secure Boot is enabled. Proceed only if"
    warn "you have verified README step 7 manually."
    confirm "Continue anyway?" || { info "Aborted."; exit 0; }
  fi

  info "Enrolling TPM2 against PCR 7 (prompts for your existing passphrase)..."
  systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 "${luks}"

  if confirm "Also enroll a FIDO2 security key now? (optional)"; then
    info "Enrolling FIDO2 (insert key; set a PIN first if it has none)..."
    systemd-cryptenroll --fido2-device=auto "${luks}"
  fi

  info "Enrolled keyslots (expect password + tpm2 [+ fido2]):"
  systemd-cryptenroll "${luks}"

  cat <<'NEXT'

tpm phase complete.
  KEEP the passphrase slot — never run --wipe-slot=password.
  Next (manual, README step 9): reboot and confirm a trusted boot unlocks with
  NO prompt, then verify the passphrase (and FIDO2 if enrolled) still work, and
  re-test hibernate/resume.

NEXT
}

usage() {
  cat <<'USAGE'
Phased install helper for host athena. Run phases in order; do the manual
firmware/reboot steps from the README in between.

  sudo ./install.sh install    <DISK> <CONFIG>   README steps 2–4
  sudo ./install.sh secureboot                   README step 6 (automatable part)
  sudo ./install.sh tpm        <LUKS-PART>        README step 8

See README.md — especially the "Critical ordering" section — before running.
USAGE
}

main() {
  local phase="${1:-}"
  shift || true
  case "${phase}" in
    install)    phase_install "$@" ;;
    secureboot) phase_secureboot "$@" ;;
    tpm)        phase_tpm "$@" ;;
    ""|-h|--help|help) usage ;;
    *) err "unknown phase '${phase}'"; usage; exit 1 ;;
  esac
}

main "$@"
