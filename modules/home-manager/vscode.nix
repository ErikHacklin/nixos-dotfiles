{ pkgs, lib, ... }: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        ms-python.python
        ms-vscode-remote.remote-ssh
        jnoortheen.nix-ide
        bierner.color-info
        github.copilot
        github.copilot-chat
      ];
      userSettings = {
        "git.suggestSmartCommit" = false;
        "editor.tabSize" = 2;
        "git.confirmSync" = false;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {
              "command" = ["nixfmt"];
            };
          };
        };
      };
    };
  };
  stylix.targets.vscode.enable = true;
}
