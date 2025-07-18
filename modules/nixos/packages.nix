{ pkgs, inputs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Utilities
    git
    dig
    pavucontrol
    wl-clipboard-rs
    
    # Fonts
    corefonts

    # Theming
    adwaita-icon-theme
    gnome-themes-extra

    # Bluetooth
    blueberry
    
    # System tools
    hyprpolkitagent
    inputs.agenix.packages."${system}".default

    #Multimedia
    variety
    spotify
    vlc
    kodi-wayland
    yt-dlp
    parabolic

    # Development
    python314
    godot
    nil
    nixfmt-rfc-style

    # Virtualization
    gnome-boxes
  ];
}
