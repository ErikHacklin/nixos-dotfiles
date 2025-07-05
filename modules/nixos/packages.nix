{ pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    dig
    adwaita-icon-theme
    corefonts
    gnome-themes-extra
    git
    pavucontrol
    kitty
    walker
    hyprpolkitagent
    niri
    kodi-wayland
    blueberry
    yt-dlp
    vlc
    spotify
    waypaper
    wl-clipboard-rs
    godot
    parabolic
    gnome-boxes
  ];
}
