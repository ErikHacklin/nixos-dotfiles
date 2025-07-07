{ pkgs, ... }:
{
  programs.wofi = {
    enable = true;
    settings = {
      width = "20%";
      height = "21%";
      columns = 1;
      prompt = "Launch application";
      content_halign = "start";
      halign = "center";
      valign = "center";
      image_size = 32;
      dynamic_lines = true;
    };
    style = ''
      #window 
      {
        font-family: "Overpass Nerd Font Propo";
        border-radius: 5px;
        border-color: #cad3f5;
        border-style: solid;
        border-width: 2px;
      }

      #outer-box
      {
        padding: 20px;
      }

      #input {
        margin-bottom: 10px;
      }

      #img {
        margin-right: 10px;
      }

      #entry:selected {
        background-color: #363a4f;
      }
    '';
  };
  home.file = {
    ".config/wofi/scripts/powermenu.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        op=$( echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | wofi -i --dmenu | awk '{print tolower($2)}' )

        case $op in 
          poweroff)
            ;&
          reboot)
            ;&
          suspend)
            systemctl $op
            ;;
          lock)
            hyprlock
            ;;
          logout)
            hyprctl dispatch exit
            ;;
        esac
      '';
    };
  };
}