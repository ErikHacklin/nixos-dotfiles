{ pkgs, ... }:
{
    programs.firefox = {
        enable = true;
        profiles = {
            default = {
                extensions = {
                    force = true;
                    # packages = with pkgs.nur.repos.rycee.firefox-addons; [
                    #     keeper-password-manager
                    #     ublock-origin
                    # ];
                };
                settings = {
                    "extensions.autoDisableScopes" = 0;
                    "extensions.update.autoUpdateDefault" = false;
                    "extensions.update.enabled" = false;
                };
            };
        };
    };
    stylix.targets.firefox.profileNames = [ "default" ];
}
