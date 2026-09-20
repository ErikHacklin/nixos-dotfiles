{ config, pkgs, lib, inputs, ... }:

{
  programs.dank-material-shell = {
    enable = true;

    systemd = {
      enable = true;             # Systemd service for auto-start
      restartIfChanged = true;   # Auto-restart dms.service when dank-material-shell changes
    };

    # Core features
    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    enableVPN = true;                  # VPN management widget
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)

    settings = {
      theme = "dark";
      dynamicTheming = true;
      # Add any other settings here
    };

    session = {
      isLightMode = false;
      # Add any other session state settings here
    };
  };
}