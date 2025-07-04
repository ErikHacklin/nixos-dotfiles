{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          vscodevim.vim
          bbenoist.nix
          ms-python.python
          ms-vscode-remote.remote-ssh
        ];
      };
    };
  };
  stylix.targets.vscode.enable = true;
}