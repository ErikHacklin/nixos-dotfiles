{ config, pkgs, ... }:

{
  # Enable networking
  networking.networkmanager.enable = true;

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  };
}
