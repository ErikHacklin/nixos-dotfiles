{ ... }:
{
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".show-battery-percentage = true;
    settings."org/gnome/shell".favorite-apps = [
      "firefox.desktop"
      "ghostty.desktop"
      "code.desktop"
      "org.gnome.Nautilus.desktop"
    ];
  };
}