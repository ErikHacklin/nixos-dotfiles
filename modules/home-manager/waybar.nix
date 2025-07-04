{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
              * {
                font-family: "JetBrainsMono Nerd Font";
                font-size: 10pt;
                font-weight: bold;
                border-radius: 6px;
                transition-property: background-color;
                transition-duration: 0.3s;
              }
              @keyframes blink_red {
                to {
                  background-color: @base08;
                  color: rgb(26, 24, 38);
                }
              }
              .warning, .critical, .urgent {
                animation-name: blink_red;
                animation-duration: 1s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
                animation-direction: alternate;
              }
              window#waybar {
                background-color: transparent;
              }
              window > box {
                margin-left: 5px;
                margin-right: 5px;
                margin-top: 5px;
                background-color: @base00;
                padding: 3px;
                padding-left:8px;
                border: 2px solid @base0D;
              }
        #workspaces {
                padding-left: 0px;
                padding-right: 4px;
              }
        #workspaces button {
                padding-top: 5px;
                padding-bottom: 5px;
                padding-left: 6px;
                padding-right: 6px;
              }
        #workspaces button.active {
                background-color: @base0D;
                color: @base00;
              }
        #workspaces button.urgent {
                color: @base00;
              }
        #workspaces button:hover {
                background-color: @base0D;
                color: @base00;
              }
              tooltip {
                background: rgb(48, 45, 65);
              }
              tooltip label {
                color: @base05;
              }
        #window {
                margin-left: 10px;
              }
        #clock, #memory, #temperature, #cpu, #backlight, #pulseaudio, #network, #battery {
                padding-left: 10px;
                padding-right: 10px;
              }
        #clock, #temperature, #battery {
                color: @base05;
              }
	#pulseaudio {
		color: @base0E;
		}
	#backlight {
		color: @base0A;
		}
	#cpu {
		color: @base0C;
		}
	#disk {
		color: @base0F;
		}
	#memory {
		color: @base09;
		}
        #network {
        	color: @base0B;
        	}
        #network.disconnected {
                color: @base08;
              }
        #tray {
                padding-right: 8px;
                padding-left: 10px;
              }
    '';
    settings = [{
      "layer" = "top";
      "position" = "top";
      modules-left = [
      	"hyprland/workspaces"
        "hyprland/window"
      ];
      modules-center = [];
      modules-right = [
        "disk"
        "pulseaudio"
        "backlight"
        "memory"
        "cpu"
        "network"
	      "battery"
	      "clock"
        "tray"
      ];
      "hyprland/workspaces" = {
	      "format" = "{name}";
      };
      "pulseaudio" = {
        "scroll-step" = 1;
        "format" = "{icon} {volume}%";
        "format-muted" = "󰖁 Muted";
        "format-icons" = {
          "default" = [ " " " " " " ];
        };
        "on-click" = "pamixer -t";
        "tooltip" = false;
      };
      "backlight" = {
	"format" = "{icon} {percent}%";
	"format-icons" = [ "" "" ];
      };
      "clock" = {
        "interval" = 1;
        "format" = "{:%I:%M %p}";
        "tooltip" = true;
        "tooltip-format"= "{=%A; %d %B %Y}\n<tt>{calendar}</tt>";
      };
      "memory" = {
        "interval" = 1;
        "format" = "󰻠 RAM: {percentage}%";
        "states" = {
          "warning" = 85;
        };
      };
      "cpu" = {
        "interval" = 1;
        "format" = "󰍛 CPU: {usage}%";
      };
      "network" = {
        "format-disconnected" = "󰯡 Disconnected";
        "format-ethernet" = "󰒢 Connected!";
        "format-linked" = "󰖪 {essid} (No IP)";
        "format-wifi" = "󰖩 {essid}";
        "interval" = 1;
        "tooltip" = false;
      };
      "tray" = {
        "icon-size" = 15;
        "spacing" = 5;
      };
      "battery" = {
	      "interval" = 60;
	      "states" = {
	        "warning" = 30;
	        "critical" = 15;
	      };
	      "format" = "{icon} {capacity}%";
	      "format-icons" = [" " " " " " " " " "];
	      "max-length" = 25;
      };
      "hyprland/window" = {
        "format" = "{}";
      };
      "disk" = {
        "format" = "{specific_free:0.2f} / {specific_total:0.2f} GB Free";
        "unit" = "GB";
        "interval" = 3600;
      };
    }];
  };
  stylix.targets.waybar.addCss = false;
}
