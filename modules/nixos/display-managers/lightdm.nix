{ config, lib, ... }:

lib.mkIf (config.networking.hostName == "kerberos") {
  services.xserver.displayManager.lightdm.enable = true;
}