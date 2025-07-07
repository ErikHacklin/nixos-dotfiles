{ pkgs, inputs, ... }:
{
    stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        polarity = "dark";
        cursor = {
            name = "BreezX-RosePine-Linux";
            package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
            size = 32;
        };
        fonts = {
            monospace.name = "JetBrainsMono Nerd Font";
            sansSerif.name = "JetBrainsMono Nerd Font";
        };
    };
}
