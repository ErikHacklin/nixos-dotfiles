{ config, pkgs, ... }:

{
  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Keep only the latest 5 NixOS generations
  boot.loader.systemd-boot.configurationLimit = 5;
}
