{ config, lib, ... }:

lib.mkIf (config.networking.hostName == "athena") {
  services.desktopManager.gnome.enable = true;
}
