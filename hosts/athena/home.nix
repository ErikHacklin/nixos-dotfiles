{ config, pkgs, ... }:

{
  imports = [ # Imported modules for Elitebook 1030 X360 G2
    ./../../modules/home-manager
  ];
  home.username = "erik";
  home.homeDirectory = "/home/erik";

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

