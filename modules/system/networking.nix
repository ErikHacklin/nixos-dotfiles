{ config, pkgs, ... }:

{
  # Enable networking
  networking.networkmanager.enable = true;

  # Firewall
  networking.firewall.enable = true;
}
