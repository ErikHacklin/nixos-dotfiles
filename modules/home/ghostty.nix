{ config, pkgs, lib, inputs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = null; # installed at system level
    enableZshIntegration = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;
    };
    systemd.enable = false;
  };
}
