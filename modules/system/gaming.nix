{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  # Enable GameMode for optimized gaming performance
  programs.gamemode.enable = true;
}
