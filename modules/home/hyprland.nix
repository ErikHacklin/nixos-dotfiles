{ config, pkgs, lib, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";
    extraConfig = ''
      hl.on("hyprland.start", function()
        hl.exec_cmd("systemctl --user start hyprpolkitagent")
      end)

      -- Volume keys
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
      hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
      hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

      -- Brightness keys
      hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })
    '';
    settings = {
      mod = {
        _var = "SUPER";
      };

      config = {
        general = {
          gaps_out = 10;
          gaps_in = 5;
        };
        input = {
          kb_layout = "fi";
        };
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };
      };

      monitor = {
        output = "";
        mode = "preferred";
        position = "auto";
        scale = 1;
      };

      bind = [
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + T"'') (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("ghostty")'') ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + W"'') (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("microsoft-edge")'') ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + F"'') (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("nautilus")'') ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + C"'') (lib.generators.mkLuaInline ''hl.dsp.window.close()'') ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + M"'') (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("loginctl terminate-user $USER")'') ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + D"'') (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("dms ipc launcher toggle")'') ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + X"'') (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("dms ipc powermenu toggle")'') ]; }
        # Workspaces
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + 1"'') (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 1 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + 2"'') (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 2 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + 3"'') (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 3 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + 4"'') (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 4 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + 5"'') (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 5 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + 6"'') (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 6 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + 7"'') (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 7 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + 8"'') (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 8 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + 9"'') (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 9 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + 0"'') (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 10 })") ]; }
        # Move window to workspace
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + SHIFT + 1"'') (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 1 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + SHIFT + 2"'') (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 2 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + SHIFT + 3"'') (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 3 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + SHIFT + 4"'') (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 4 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + SHIFT + 5"'') (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 5 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + SHIFT + 6"'') (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 6 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + SHIFT + 7"'') (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 7 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + SHIFT + 8"'') (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 8 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + SHIFT + 9"'') (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 9 })") ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + SHIFT + 0"'') (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 10 })") ]; }
      ];
    };
  };
}
