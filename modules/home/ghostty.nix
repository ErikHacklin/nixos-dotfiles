{ config, pkgs, lib, inputs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = null; # installed at system level
    enableZshIntegration = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;
      background-opacity = 0.90;
      background-blur = true;
    };
    systemd.enable = false;
  };
}
