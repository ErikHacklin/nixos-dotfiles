{ config, lib, ... }:

lib.mkIf (config.networking.hostName == "athena") {
  services.displayManager.gdm.enable = true;
}