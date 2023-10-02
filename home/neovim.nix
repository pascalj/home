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
  github-nvim-theme = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "github-nvim-theme";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "projekt0n";
      repo = "github-nvim-theme";
      rev = "c8b55752294b9e83bd544f5ebf4ba485aec7e3c7";
      hash = "sha256-CmIqpwG9H03ndxh8wT7d1BaDKLC+j00JcInkwNfaR2U=";
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
in
{
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
    vim-surround
    neogen
    minimap-vim
    nvim-lspconfig
    telescope-nvim
    nvim-autopairs
    telescope-heading
    (nvim-treesitter.withPlugins (
      plugins: with plugins; [
        c
        cpp
        latex
        markdown
        nix
        python
        r
      ]
    ))

    moonfly
    github-nvim-theme
    configuration
  ];
}

