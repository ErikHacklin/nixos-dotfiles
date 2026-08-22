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
    ../../modules/system/dms-shell.nix
  ];

  networking.hostName = "athena";

  system.stateVersion = "26.05";
}
