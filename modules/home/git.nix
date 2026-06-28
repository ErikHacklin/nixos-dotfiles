{ config, pkgs, lib, inputs, ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "Erik Hacklin";
      email = "erik.hacklin@gmail.com";
    };
  };
}
