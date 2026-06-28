{ config, pkgs, ... }:

{
  # Enable fstrim for SSD health and performance.
  services.fstrim.enable = true;

  # Enable OpenSSH with hardened settings.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
