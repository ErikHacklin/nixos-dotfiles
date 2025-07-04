{ pkgs, ... }: {
  # Enable Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  # Enable Feral Gamemode
  programs.gamemode.enable = true;
}