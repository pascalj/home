{ pkgs, lib, ... }:

let
  github-nvim-theme = pkgs.vimUtils.buildVimPlugin {
    pname = "github-nvim-theme";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "projekt0n";
      repo = "github-nvim-theme";
      rev = "c8b55752294b9e83bd544f5ebf4ba485aec7e3c7";
      hash = "sha256-CmIqpwG9H03ndxh8wT7d1BaDKLC+j00JcInkwNfaR2U=";
    };
  };
  telescope-heading = pkgs.vimUtils.buildVimPlugin {
    pname = "telescope-heading";
    version = "0.7.0";
    src = pkgs.fetchFromGitHub {
      owner = "crispgm";
      repo = "telescope-heading.nvim";
      rev = "39e549c8dbe24bdf4545547ab9cebf2ab6597bc2";
      hash = "sha256-y/GYH4FYRGTkl9eTtA5mO1XLvFGFCsNLoUuYLl+EAt4=";
    };
  };
  configuration = pkgs.vimUtils.buildVimPlugin {
    pname = "configuration";
    version = "v1.0.0";
    src = ./.;
  };
in
{
  enable = true;
  viAlias = true;
  vimAlias = true;
  withRuby = false;
  withNodeJs = false;

  extraConfig = lib.fileContents ./init.vim;

  plugins = with pkgs.vimPlugins; [
    catppuccin-nvim
    github-nvim-theme
    goto-preview
    lualine-nvim
    minimap-vim
    nvim-autopairs
    nvim-lspconfig
    nvim-navic
    telescope-heading
    telescope-nvim
    vim-commentary
    vim-dispatch
    vim-fugitive
    vim-localvimrc
    vim-nix
    vim-sleuth
    vim-surround
    (nvim-treesitter.withPlugins (
      plugins: with plugins; [
        c
        cpp
        latex
        markdown
        nix
        python
        r
        typescript
      ]
    ))
    configuration
  ];
}

