{ config, pkgs, lib, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";
    extraConfig = ''
      hl.on("hyprland.start", function()
        hl.exec_cmd("noctalia")
      end)
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
        mode = "1920x1080@60";
        position = "auto";
        scale = 1;
      };

      bind = [
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + T"'') (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("ghostty")'') ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + W"'') (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("microsoft-edge")'') ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + F"'') (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("nautilus")'') ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + C"'') (lib.generators.mkLuaInline ''hl.dsp.window.close()'') ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + M"'') (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("loginctl terminate-user $USER")'') ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + D"'') (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg panel-toggle launcher")'') ]; }
        { _args = [ (lib.generators.mkLuaInline ''mod .. " + X"'') (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg panel-toggle session")'') ]; }
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
