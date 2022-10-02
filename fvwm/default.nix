{ config, lib, pkgs, ... }:

let

  fvwm-config = pkgs.stdenv.mkDerivation {
    name = "fvwm-config";
    dontBuild = true;
    installPhase = ''
      cp -aR $src $out
    '';
    src = ./config;
  };

in {
  imports = [
    # ./picom.nix
  ];

  xsession = {
    enable = true;
    initExtra = ''
      xrandr -s 1920x1080
      setxkbmap "us_programmer(dvorak-emacs)"
    '';
    windowManager.command = "${pkgs.fvwm}/bin/fvwm -f ${fvwm-config}/config";
  };

  xsession.profileExtra = ''
    export FVWM_DATADIR="${fvwm-config}";
    export FVWM_USERDIR="${fvwm-config}";

    export fvwm_img="${fvwm-config}/images";
    export fvwm_icon="${pkgs.crystal-nova-icon-theme}/share/icons/crystal-nova";
    export fvwm_wallpaper="${fvwm-config}/images/wallpaper";
    export fvwm_cache="/tmp/fvwm-cache";
    export fvwm_scripts="${fvwm-config}/scripts";

    export fvwm_term=konsole;
    export fvwm_browser=firefox;
    export fvwm_editor="emacsclient -c";
    export fvwm_file_manager="dolphin";
    export fvwm_music_player=strawberry;
    # export fvwm_video_player=config.apps.videoPlayer.command;
    export fvwm_launch="xdotool mousemove 1800 1080; emacsclient -e '(emacs-run-launcher)'";
    export fvwm_chat="discord";
    export fvwm_mail="thunderbird";

    export QT_AUTO_SCREEN_SCALE_FACTOR="0";
    export PLASMA_USE_QT_SCALING="1";
  '';

  home.packages = with pkgs; [
    fvwm
    fvwm-config
    feh
    xorg.xwd
    xlockmore
	  stalonetray
    flameshot
    pavucontrol
    pasystray
    networkmanagerapplet
    xdgmenumaker
    xbrightness
    imagemagick
    kde-gtk-config
    trash-cli
    xdotool

    conky
    lua
    # lm_sensors
    lsb-release

    libsForQt5.plasma-systemmonitor

    picom
  ];

  home.file.".config/conky/conky.conf".source = ./conky.conf;

  home.pointerCursor = {
    name = "Oxygen_White";
    size = 48;
    gtk.enable = true;
    package = pkgs.libsForQt5.oxygen;
    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
  };
}
