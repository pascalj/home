{ pkgs, lib, ... }:

let
  moonfly = pkgs.vimUtils.buildVimPlugin {
    pname = "moonfly";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "bluz71";
      repo = "vim-moonfly-colors";
      rev = "5fc39cbc04de7395db942758a546c7f87bfcb571";
      sha256 = "sha256-2/wENDHSLSSGwrnFqF2c54rMYbCGv47y6Geu4PW0grI=";
    };
  };
    configuration = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "configuration";
      version = "v1.0.0";
      src = ./neovim;
    };
in {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withNodeJs = false;

    extraConfig = lib.fileContents ./neovim/init.vim;



    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-airline
      vim-sleuth
      vim-commentary
      vim-dispatch
      vim-fugitive
      fzf-vim
      vim-pandoc
      vim-pandoc-syntax
      nvim-lspconfig

      moonfly
      configuration
    ];
  }

