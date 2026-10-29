# /etc/nixos/modules/system/secureboot.nix
{ pkgs, lib, inputs, ... }:

{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  environment.systemPackages = [
    pkgs.sbctl   # create/enroll/verify Secure Boot keys; debugging
  ];

  # Lanzaboote replaces systemd-boot. boot.nix sets systemd-boot.enable = true,
  # so force it off here.
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";   # current recommended path (verified upstream)
  };
}
