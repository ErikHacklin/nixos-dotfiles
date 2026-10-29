{ config, pkgs, lib, inputs, ... }:

{
  programs.dank-material-shell = {
    enable = true;

    systemd = {
      enable = true;             # Systemd service for auto-start
      restartIfChanged = true;   # Auto-restart dms.service when dank-material-shell changes
    };

    # Plugins. Declaring settings here makes the module manage
    # ~/.config/dms/plugin_settings.json (read-only symlink) — edit plugin
    # settings here, not in the GUI.
    plugins = {
      wallarchyDms = {
        enable = true;
        # Pinned to the commit from plugins.lock.json for reproducibility.
        src = pkgs.fetchFromGitHub {
          owner = "alamin147";
          repo = "wallarchyDms";
          rev = "5b83aa33cc64e9f940e95e1b5f3d74ccd25478ae";
          hash = "sha256-2ILor1ySzdtWC2AdyU14NMUSCdDwzO10UpDKlhiUckk=";
        };
        settings = {
          categories = "001";
          atleast = "1920x1080";
          sorting = "views";
          downloadDir = "/home/erik/Pictures/Wallpapers";
        };
      };
    };

    # Core features
    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    enableVPN = true;                  # VPN management widget
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = false;       # Calendar integration (khal)

    # Written verbatim to ~/.config/dms/settings.json (read-only symlink).
    # Captured from the DMS settings GUI "export"; edit here, not in the GUI,
    # since home-manager owns this file.
    settings = {
      theme = "dark";
      dynamicTheming = true;

      dockConfigs = [
        {
          id = "dock";
          name = "Dock";
          enabled = false;
          screenPreferences = [ "all" ];
          showOnLastDisplay = true;
          position = 1;
          mode = "compact";
          taskbarAlign = "center";
          widgetExpansion = "popout";
          iconSize = 40;
          spacing = 4;
          itemSpacing = 4;
          margin = 0;
          bottomGap = 0;
          transparency = 1;
          followInterfaceStyle = true;
          autoHide = false;
          smartAutoHide = false;
          useOverlayLayer = false;
          editOnRightClick = false;
          showOnFullscreen = false;
          openOnOverview = false;
          groupByApp = false;
          separatePinnedAndRunningApps = false;
          restoreSpecialWorkspaceOnClick = false;
          isolateDisplays = false;
          indicatorStyle = "circle";
          borderEnabled = false;
          borderColor = "surfaceText";
          borderOpacity = 1;
          borderThickness = 1;
          launcherEnabled = false;
          launcherLogoMode = "apps";
          launcherLogoCustomPath = "";
          launcherLogoColorOverride = "";
          launcherLogoSizeOffset = 0;
          launcherLogoBrightness = 0.5;
          launcherLogoContrast = 1;
          maxVisibleApps = 0;
          maxVisibleRunningApps = 0;
          showOverflowBadge = true;
          showTrash = false;
          trashFileManager = "default";
          trashCustomCommand = "";
          magnification = false;
          magnificationScale = 130;
          magnificationProfile = "parabolic";
          magnificationExpand = false;
          order = [ ];
          widgets = [
            { id = "dock_launcher"; widgetId = "dockLauncher"; enabled = true; }
            { id = "dock_apps"; widgetId = "appsDock"; enabled = true; }
            { id = "dock_trash"; widgetId = "dockTrash"; enabled = true; }
          ];
        }
      ];

      dmsWindowsFloatingSeeded = [ "hyprland" ];
      barElevationEnabled = false;

      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = [ "all" ];
          showOnLastDisplay = true;
          leftWidgets = [
            "launcherButton"
            "workspaceSwitcher"
            "focusedWindow"
          ];
          centerWidgets = [
            "music"
            "clock"
            "weather"
          ];
          rightWidgets = [
            { id = "wallarchyDms"; enabled = true; }
            "systemTray"
            "clipboard"
            "cpuUsage"
            "memUsage"
            "notificationButton"
            "battery"
            "controlCenterButton"
          ];
          spacing = 4;
          innerPadding = 4;
          bottomGap = 0;
          transparency = 1;
          widgetTransparency = 1;
          squareCorners = false;
          noBackground = false;
          gothCornersEnabled = false;
          gothCornerRadiusOverride = false;
          gothCornerRadiusValue = 12;
          borderEnabled = false;
          borderColor = "surfaceText";
          borderOpacity = 1;
          borderThickness = 1;
          fontScale = 1;
          autoHide = false;
          autoHideDelay = 250;
          openOnOverview = false;
          visible = true;
          popupGapsAuto = true;
          popupGapsManual = 4;
          followInterfaceStyle = true;
          widgetFollowInterfaceStyle = true;
        }
      ];

      builtInPluginSettings = {
        dms_qr_generator.trigger = "qrg";
        dms_power.trigger = "pw";
        dms_clipboard_search.trigger = "cb";
        dms_settings_search.trigger = "?";
      };
    };

    # Written verbatim to ~/.local/state/dms/session.json (read-only symlink).
    session = {
      isLightMode = false;

      wallpaperCyclingEnabled = true;
      wallpaperCyclingRandom = true;
      wallpaperCyclingRecursive = true;
      wallpaperCyclingInterval = 7200;
      wallpaperCyclingFolderPath = "/home/erik/Pictures/Wallpapers";
      showThirdPartyPlugins = true;
      configVersion = 7;
    };
  };
}
