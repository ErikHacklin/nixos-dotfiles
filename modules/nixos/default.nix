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
      ./../../modules/nixos/ssh.nix
      ./../../modules/nixos/stylix.nix
      ./../../modules/nixos/tailscale.nix
      ./../../modules/nixos/gaming.nix
      ./../../modules/nixos/fonts.nix
      ./../../modules/nixos/virtualisation.nix
    ];
}