{ config, pkgs, lib, ... }:
{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs; [
    bat
    fd
    htop
    ripgrep
    lazygit
    watson
    iosevka
    tree
  ];

  fonts.fontconfig.enable = true;

  # Programs
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.git = {
    enable = true;
    userName = "Pascal Jungblut";
    userEmail = "mail@pascalj.de";
    ignores = [ ".lvimrc" ];
    aliases = {
      st = "status";
      co = "checkout";
    };
    diff-so-fancy.enable = true;
  };
  programs.jq.enable = true;
  programs.neovim = import ./home/neovim {
    inherit pkgs lib;
  };
  programs.rofi = {
    enable = true;
    plugins = [ pkgs.rofi-calc ];
    theme = ./home/rofi/nord.rasi;
  };
  programs.zsh = import ./home/zsh {
    inherit config lib pkgs;
  };

  # dotfiles
  home.file = import ./home/dotfiles {
    inherit pkgs lib;
  };
}
