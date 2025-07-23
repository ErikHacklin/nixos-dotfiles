{config, lib, ...}:
 
 lib.mkIf (config.networking.hostName == "athena") {
  programs.hyprland.enable = true;
}