{ config, lib, pkgs, ... }:

{
  imports = [
    ./packages
    ./emacs
    ./fvwm
  ];

  home.username = "cory";
  home.homeDirectory = "/home/cory";
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;

  fonts.fontconfig.enable = true;

  xresources.extraConfig = ''
    Xft.dpi: 96
    Xft.antialias: 1
    Xft.hinting: 1
    Xft.autohint: 0
    Xft.hintstyle: hintslight
    Xft.rgba: rgb
    Xft.lcdfilter: lcddefault
  '';

  programs.cory.emacs.enable = true;

  programs.git = {
    enable = true;
    userName  = "corytertel";
    userEmail = "ctertel@comcast.net";
  };

  home.packages = with pkgs; [
    # Ubuntu replacement packages
    firefox
    nano
    wget
    procps
    psmisc
    gdb

    # Essential packages
    curl
    fd
    ripgrep
    btop

    # C++
    ccls
    clang
    clang-tools # clang-tidy and clang-analyzer
    libcxx
    cppcheck
    global

    # Theme
    victor-mono
    oxygenfonts
    crystal-nova-icon-theme

    # User Apps
    libsForQt5.konsole
    libsForQt5.gwenview
    libsForQt5.dolphin
    discord
    strawberry
  ];
}

