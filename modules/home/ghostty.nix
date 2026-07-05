{ config, pkgs, lib, inputs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = null; # installed at system level
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;
    };
  };
}
