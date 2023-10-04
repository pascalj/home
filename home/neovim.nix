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
  colors-pencil = pkgs.vimUtils.buildVimPlugin {
    pname = "colors-pencil";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "preservim";
      repo = "vim-colors-pencil";
      rev = "1101118fa3e3038568541e9a67511513aac5d19b";
      sha256 = "sha256-l/v5wXs8ZC63OmnI1FcvEAvWJWkaRoLa9dlL1NdX5XY=";
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
  telescope-heading = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "telescope-heading";
    version = "0.7.0";
    src = pkgs.fetchFromGitHub {
      owner = "crispgm";
      repo = "telescope-heading.nvim";
      rev = "39e549c8dbe24bdf4545547ab9cebf2ab6597bc2";
      hash = "sha256-y/GYH4FYRGTkl9eTtA5mO1XLvFGFCsNLoUuYLl+EAt4=";
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
      goto-preview
      nvim-lspconfig
      telescope-nvim
      nvim-autopairs
      telescope-heading
      (nvim-treesitter.withPlugins (
          plugins: with plugins; [
            nix
            python
            markdown
            c
            cpp
            latex
            r
          ]
        ))
      moonfly
      colors-pencil
      configuration
    ];
  }

