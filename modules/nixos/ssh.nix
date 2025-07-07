{ pkgs, ... }:
{
    services.openssh = {
        enable = true;
        settings = {
            AllowUsers = [ "erik" ];
            PermitRootLogin = "no";
            PasswordAuthentication = false;
        };
        openFirewall = true;
    };
}