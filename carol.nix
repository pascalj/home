{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.clang-tools
  ];
}
