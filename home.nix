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
    pkgs.bat
    pkgs.clang-tools
    pkgs.fd
    pkgs.htop
    pkgs.ripgrep
    pkgs.lazygit
    (pkgs.rWrapper.override{ packages = with pkgs.rPackages; [ tidyverse here ]; })
    pkgs.python310Packages.timetagger
    (pkgs.iosevka.override {
      set = "pascal";
      privateBuildPlan = ''
        [buildPlans.iosevka-pascal]
        family = "Iosevka Pascal"
        spacing = "term"
        serifs = "sans"
        no-cv-ss = true
        export-glyph-names = true

          [buildPlans.iosevka-pascal.ligations]
          inherits = "clike"

        [buildPlans.iosevka-pascal.weights.regular]
        shape = 400
        menu = 400
        css = 400

        [buildPlans.iosevka-pascal.weights.bold]
        shape = 700
        menu = 700
        css = 700

        [buildPlans.iosevka-pascal.slopes.upright]
        angle = 0
        shape = "upright"
        menu = "upright"
        css = "normal"

        [buildPlans.iosevka-pascal.slopes.italic]
        angle = 9.4
        shape = "italic"
        menu = "italic"
        css = "italic"
      '';
    })
  ];

  fonts.fontconfig.enable = true;
  programs.jq.enable = true;
  programs.rofi = {
    enable = true;
    plugins = [ pkgs.rofi-calc ];
    theme = "${config.xdg.configHome}/nixpkgs/home/rofi/nord.rasi";
  };
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
