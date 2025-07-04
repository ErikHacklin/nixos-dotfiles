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
        userSettings = {
          "git.suggestSmartCommit" = false;
          "editor.tabSize" = 2;
        }
      };
    };
  };
  stylix.targets.vscode.enable = true;
}