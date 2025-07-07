{ config, pkgs, inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/nixos/boot.nix
      ./../../modules/nixos/time.nix
      ./../../modules/nixos/locale.nix
      ./../../modules/nixos/users.nix
      ./../../modules/nixos/packages.nix
      ./../../modules/nixos/audio.nix
      ./../../modules/nixos/ssh.nix
      ./../../modules/nixos/stylix.nix
      ./../../modules/nixos/tailscale.nix
      ./../../modules/nixos/gaming.nix
      ./../../modules/nixos/fonts.nix
      ./../../modules/nixos/virtualisation.nix
    ];

  networking.hostName = "athena"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the Gnome Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

    
  # Enable Hyprland
  programs.hyprland.enable = true;
  
  programs.nh = {
    enable = true;
    flake = "/home/erik/Repositories/nixos-dotfiles";
  };

  programs.fish.enable = true;

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fi";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fi";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable IIO for screen auto-rotate
  hardware.sensor.iio.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.gnome.gnome-keyring.enable = true; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nix.optimise.automatic = true;
  
  nix.gc = {
    persistent = true;
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than-30d";
  };
  
  system.stateVersion = "24.11"; # Did you read the comment?
}
