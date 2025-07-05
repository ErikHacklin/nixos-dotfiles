{ config, pkgs, ... }: {
  home.file.".config/variety/scripts/set_wallpaper".text = ''
    #!/usr/bin/env bash
    # The default is to simply set WP=$1.
    WP=$1

    if [ "$XDG_SESSION_DESKTOP" == "Hyprland" ] || [ "$DESKTOP_SESSION" == "hyprland" ] || [ "$DESKTOP_SESSION" == "river" ]; then
        # Is the swww-daemon running?
        #SWWW=$(pidof swww-daemon)
        if [ -n "$(pidof swww-daemon)" ]; then
            swww img --resize fit --transition-type=wipe --transition-angle 30 --transition-fps 60 "$WP"
        fi
        else
            # See if SwayBG is running and nuke its last instance if it is.
            old_swaybg=$(pgrep -f swaybg)
            if [ -n "$old_swaybg" ]; then
                killall swaybg &
                swaybg -i "$WP" -m fit
            fi
        fi
    fi

    else
        # For simple WMs, use either feh or nitrogen
        # TODO: These should take the scaling parameter $4 into account and use other options than --bg-fill
        if command -v "feh" >/dev/null 2>&1; then
            feh --bg-fill "$WP" 2>/dev/null
        elif command -v "nitrogen" >/dev/null 2>&1; then
            nitrogen --set-zoom-fill --save "$WP" 2>/dev/null
        fi
    fi

    echo "Wallpaper set to: $WP"
    # Exit with success

    exit 0
  '';
  home.file.".config/variety/scripts/set_wallpaper".executable = true;
}
