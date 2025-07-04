{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Erik Hacklin";
    userEmail = "erik.hacklin@gmail.com";
  };
}