{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    extraConfig = ''

    # Monitors
    monitor = eDP-1,preferred,auto,1
    
    '';

    settings = {
      exec-once = [
      	"waybar &"
	"systemctl --user start hyprpolkitagent"
	"variety &"
      ];
      general = {
          "$mainMod" = "SUPER";
	  "$launcher" = "walker";
	  "$browser" = "firefox";
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
      };
      decoration = {
        rounding = 2;
      };
      input = {
        kb_layout = "fi";
      };
      cursor = {
      	inactive_timeout = 5;
	hide_on_key_press = true;
	hide_on_touch = true;
      };
      misc = {
        disable_hyprland_logo = true;
      };
      animations = {
        enabled = true;

	bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "fade_curve, 0, 0.55, 0.45, 1"
        ];

        animation = [
          # name, enable, speed, curve, style

          # Windows
          "windowsIn,   0, 4, easeOutCubic,  popin 20%" # window open
          "windowsOut,  0, 4, fluent_decel,  popin 80%" # window close.
          "windowsMove, 1, 2, fluent_decel, slide" # everything in between, moving, dragging, resizing.

          # Fade
          "fadeIn,      1, 3,   fade_curve" # fade in (open) -> layers and windows
          "fadeOut,     1, 3,   fade_curve" # fade out (close) -> layers and windows
          "fadeSwitch,  0, 1,   easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow,  1, 10,  easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim,     1, 4,   fluent_decel" # the easing of the dimming of inactive windows
          # "border,      1, 2.7, easeOutCirc"  # for animating the border's color switch speed
          # "borderangle, 1, 30,  fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
          "workspaces,  1, 4,   easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
        ];
      };
      bind = [
	# Custom keybinds
	"$mainMod, W, exec, firefox"
	"$mainMod, F, exec, nautilus"
	"$mainMod, T, exec, ghostty"
	"$mainMod, D, exec, $launcher"
	"$mainMod, L, exec, hyprlock"

	"$mainMod, C, killactive,"
	"$mainMod, M, exit,"
	
	# Variety keybinds
	"$mainMod SHIFT, T, exec, variety --trash"
	"$mainMod SHIFT, P, exec, variety --previous"
	"$mainMod SHIFT, N, exec, variety --next"

	# Move focus with mainMod + arrow keys
	"$mainMod, left, movefocus, l"
	"$mainMod, right, movefocus, r"
	"$mainMod, up, movefocus, u"
	"$mainMod, down, movefocus, d"

	# switch workspaces with mainMod + [0-9]
	"$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

	# Move active window to a workspace with mainMod + SHIFT + [0-9]
	"$mainMod SHIFT, 1, movetoworkspace, 1"
	"$mainMod SHIFT, 2, movetoworkspace, 2"
	"$mainMod SHIFT, 3, movetoworkspace, 3"
	"$mainMod SHIFT, 4, movetoworkspace, 4"
	"$mainMod SHIFT, 5, movetoworkspace, 5"
	"$mainMod SHIFT, 6, movetoworkspace, 6"
	"$mainMod SHIFT, 7, movetoworkspace, 7"
	"$mainMod SHIFT, 8, movetoworkspace, 8"
	"$mainMod SHIFT, 9, movetoworkspace, 9"
	"$mainMod SHIFT, 0, movetoworkspace, 10"
      ];
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
	# Requires playerctl
	", XF86AudioPlay, exec, playerctl play-pause"
	", XF86AudioPrev, exec, playerctl previous"
	", XF86AudioNext, exec, playerctl next"
      ];
      windowrule = [
        "tile, class:Godot"
      ];
    };
  };
}
