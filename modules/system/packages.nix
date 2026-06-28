{ config, pkgs, ... }:

{
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    kiro-fhs
    microsoft-edge
    ghostty
    neovim
    git
    wget
    variety
    nautilus
  ];

  # Default editor
  environment.variables.EDITOR = "nvim";
}
