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
  neogen = pkgs.vimUtils.buildVimPlugin {
    pname = "neogen";
    version = "2.13.0";
    src = pkgs.fetchFromGitHub {
      owner = "danymat";
      repo = "neogen";
      rev = "fbc3952024d2c0d57b92a3802e9e29c789abcd18";
      sha256 = "sha256-m9jiH3DkutORUVMDJ7UoS8bvZ8TBzDu01IRYZkIGibs=";
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
      vim-localvimrc
      neogen
      minimap-vim
      nvim-lspconfig
      telescope-nvim
      (nvim-treesitter.withPlugins (
          plugins: with plugins; [
            nix
            python
            markdown
            c
            cpp
            latex
          ]
        ))

      moonfly
      configuration
    ];
  }

