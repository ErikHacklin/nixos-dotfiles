{ pkgs, ... }:
{
  imports = [
      ./hardware-configuration.nix
      ./../../modules/nixos
    ];

  networking.hostName = "athena"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the Gnome Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable IIO for screen auto-rotate
  hardware.sensor.iio.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.gnome.gnome-keyring.enable = true; 

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.optimise.automatic = true;
  
  nix.gc = {
    persistent = true;
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than-30d";
  };
  
  system.stateVersion = "25.11";
}
