{ ... }:
{
  imports =
    [
      ./../../modules/nixos/boot.nix
      ./../../modules/nixos/security.nix
      ./../../modules/nixos/time.nix
      ./../../modules/nixos/locale.nix
      ./../../modules/nixos/users.nix
      ./../../modules/nixos/packages.nix
      ./../../modules/nixos/audio.nix
      ./../../modules/nixos/bluetooth.nix
      ./../../modules/nixos/ssh.nix
      ./../../modules/nixos/stylix.nix
      ./../../modules/nixos/tailscale.nix
      ./../../modules/nixos/gaming.nix
      ./../../modules/nixos/fonts.nix
      ./../../modules/nixos/virtualisation.nix
      ./../../modules/nixos/desktop-managers/hyprland.nix
      ./../../modules/nixos/desktop-managers/gnome.nix
      ./../../modules/nixos/desktop-managers/budgie.nix
      ./../../modules/nixos/display-managers/gdm.nix
      ./../../modules/nixos/display-managers/lightdm.nix
    ];
}