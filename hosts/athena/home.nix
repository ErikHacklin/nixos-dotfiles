{ config, pkgs, ... }:

{
  imports = [ # Imported modules for Elitebook 1030 X360 G2
      ./../../modules/home-manager/packages.nix
      ./../../modules/home-manager/hyprland.nix
      ./../../modules/home-manager/waybar.nix
      ./../../modules/home-manager/git.nix
      ./../../modules/home-manager/fish.nix
      ./../../modules/home-manager/ghostty.nix
      ./../../modules/home-manager/vscode.nix
      ./../../modules/home-manager/hyprpaper.nix
      ./../../modules/home-manager/starship.nix
      ./../../modules/home-manager/neovim.nix
      ./../../modules/home-manager/firefox.nix
      ./../../modules/home-manager/hyprsunset.nix
      ./../../modules/home-manager/hyprlock.nix
    ];
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

