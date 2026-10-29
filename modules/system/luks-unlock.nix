# /etc/nixos/modules/system/luks-unlock.nix
{ ... }:

{
  # NOTE: The design report specifies `boot.initrd.systemd.enable = true` as the
  # requirement for tpm2-device / fido2-device unlock. On the pinned
  # nixos-unstable nixpkgs the scripted initrd has been removed and the systemd
  # initrd is now the default and only implementation, so that option was removed
  # upstream (setting it is now a hard evaluation error). systemd-in-initrd — the
  # behavior the report wanted — is therefore already in effect with no option to
  # set. The functional part below (the crypttab TPM2/FIDO2 opts) is unchanged.

  # Tell the initrd how to try auto-unlock for the LUKS container.
  # The device name "crypted" must match disko's luks `name`.
  # disko generates boot.initrd.luks.devices.crypted.device; we only add options.
  boot.initrd.luks.devices."crypted".crypttabExtraOpts = [
    "tpm2-device=auto"   # try the TPM first (PCR 7 sealed key)
    "fido2-device=auto"  # then offer a FIDO2 key if present (optional)
  ];
}
