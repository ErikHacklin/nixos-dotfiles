{ config, pkgs, inputs, ... }:

{
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = (with pkgs; [
    gnome-disk-utility
    kiro-fhs
    microsoft-edge
    ghostty
    neovim
    git
    wget
    variety
    nautilus
    nixd
    brightnessctl
    wev
    docker-compose
    hyprpolkitagent
    jellyfin-desktop
  ]) ++ [
    inputs.freegosy.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # Default editor
  environment.variables.EDITOR = "nvim";
}
