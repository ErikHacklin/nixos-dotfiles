{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/boot.nix
    ../../modules/system/desktop.nix
    ../../modules/system/locale.nix
    ../../modules/system/networking.nix
    ../../modules/system/users.nix
    ../../modules/system/packages.nix
    ../../modules/system/services.nix
    ../../modules/system/nix-settings.nix
    ../../modules/system/nh.nix
  ];

  networking.hostName = "athena";

  system.stateVersion = "26.05";
}
