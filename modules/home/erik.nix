{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hyprland.nix
    ./git.nix
    ./theme.nix
    ./shell.nix
    ./ghostty.nix
  ];

  # Home Manager state version — matches your NixOS stateVersion.
  home.stateVersion = "26.05";

  # Let Home Manager manage itself.
  programs.home-manager.enable = true;
}
