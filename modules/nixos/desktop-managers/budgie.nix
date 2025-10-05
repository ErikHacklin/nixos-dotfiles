{ config, lib, ... }:

lib.mkIf (config.networking.hostName == "kerberos") {
  services.xserver.desktopManager.budgie.enable = true;
}