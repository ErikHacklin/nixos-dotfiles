{ config, pkgs, ... }:

{
  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Noctalia binary cache
  nix.settings.substituters = [ "https://noctalia.cachix.org" ];
  nix.settings.trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];

  # Keep only the latest 5 NixOS generations
  boot.loader.systemd-boot.configurationLimit = 5;
}
