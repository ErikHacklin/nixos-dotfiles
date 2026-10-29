{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ../../modules/system/boot.nix
    ../../modules/system/desktop.nix
    ../../modules/system/locale.nix
    ../../modules/system/networking.nix
    ../../modules/system/users.nix
    ../../modules/system/packages.nix
    ../../modules/system/services.nix
    ../../modules/system/nix-settings.nix
    ../../modules/system/nh.nix
    ../../modules/system/gaming.nix
    ../../modules/system/luks-unlock.nix
    ../../modules/system/sops.nix
    ../../modules/system/secureboot.nix  # ENABLE AT RUNBOOK STEP 6 — see README; enabling before Secure Boot keys are set up would switch the bootloader to lanzaboote
  ];

  networking.hostName = "athena";

  system.stateVersion = "26.05";
}
