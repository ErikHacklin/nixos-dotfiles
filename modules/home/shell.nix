{ config, pkgs, lib, inputs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    completions.enable = true;
    history = {
      size = 10000;
      ignoreAllDups = true;
    };
    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      tree = "eza --tree";
    };
  };

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
  };

  programs.zoxide = {
    enable = true;
  };

  programs.starship = {
    enable = true;
  };
}
