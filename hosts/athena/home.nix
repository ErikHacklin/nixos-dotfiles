{ config, pkgs, ... }:
{
  home.username = "erik";
  home.homeDirectory = "/home/erik";

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
  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

