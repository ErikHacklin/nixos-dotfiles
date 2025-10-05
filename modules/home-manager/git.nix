{ ... }: {
  programs.git = {
    enable = true;
    userName = "Erik Hacklin";
    userEmail = "erik.hacklin@gmail.com";
    extraConfig = {
      fetch.prune = true;
      pull.rebase = false;
    };
  };
}