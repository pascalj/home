{ config, lib, pkgs }:

{
  enable = true;

  dotDir = ".config/zsh";

  autocd = true;


  history = {
    size = 10000;
    save = 10000;
    ignoreDups = true;
    ignoreSpace = true;
    extended = true;
    share = false;
    path = "${config.xdg.dataHome}/zsh/zsh_history";
  };

  initExtra = lib.fileContents ./zsh/zshrc;

      plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];
}
