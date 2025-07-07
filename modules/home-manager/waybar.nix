{ ... }: {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
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
        "bluetooth"
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
      "bluetooth" = {
        "on-click" = "blueberry";
        "format-connected" = "󰂯 {device_alias}";
        "tooltip" = false;
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
