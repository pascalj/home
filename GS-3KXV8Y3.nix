{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    ghidra-bin
    radare2
    hexyl
    nodejs_20
    gdbHostCpuOnly
    # clang_16
    # doxygen
    compdb
    # plistutil # to package...
    # arcanist # package broken?
    # cmakeCurses # fucks up OpenSSL
    lit
    jemalloc
    playwright
  ];
}
