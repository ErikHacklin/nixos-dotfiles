{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
  };
  users.users.erik.extraGroups = [ "docker" ];
}
