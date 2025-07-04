{ pkgs, ... }: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;
      preload = [
        "~/Pictures/Wallpapers/wallpaper.jpg"
      ];
      wallpaper = [
        "eDP-1,~/Pictures/Wallpapers/wallpaper.jpg"
	"HDMI-A-1, ~/Pictures/Wallpapers/wallpaper.jpg"
      ];
    };
  };
}