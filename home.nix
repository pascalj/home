{ config, pkgs, lib, ... }:


{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "pascalj";
  home.homeDirectory = "/home/pascalj";


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.clang-tools
    pkgs.fd
    pkgs.htop
    pkgs.ripgrep
  ];

  programs.jq.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "Pascal Jungblut";
    userEmail = "mail@pascalj.de";
    ignores = [ ".lvimrc" ];
  };

  programs.neovim = import ./home/neovim.nix {
    inherit pkgs lib;
  };

  programs.zsh = import ./home/zsh.nix {
    inherit config lib pkgs;
  };

}
