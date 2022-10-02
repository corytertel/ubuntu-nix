{ config, lib, pkgs, ... }:

{
  services.picom = {
    enable = true;
    experimentalBackends = false;
    package = pkgs.picom;

    backend = "xrender";
    vSync = false;

    fade = false;

    opacityRules = [
      # "93:class_g = 'Emacs' && !_NET_WM_STATE@:32a" "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      "70:class_g *?= 'FvwmButtons'"
      "70:class_g *?= 'Conky'"
    ];

    settings = {
      corner-radius = 0;
      round-borders = 0;
      rounded-corners-exclude = [
        "class_g *?= 'FvwmButtons'"
        "class_g *?= 'Conky'"
      ];

      shadow = true;
      shadow-radius = 20;
      shadow-opacity = 0.80;
      shadow-offset-x = -20;
      shadow-offset-y = -10;
      shadow-exclude = [
        "class_g *?= 'FvwmButtons'"
        "class_g *?= 'Conky'"
      ];
      clip-shadow-above  = [
        "class_g *?= 'FvwmButtons'"
        "class_g *?= 'Conky'"
      ];

      blur = {
        method = "kernel";
        kernel = "11,11,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0";
      };
      blur-background-exclude = [
        "class_g *?= 'peek'"
      ];

      wintypes = {
        dock = { shadow = true; };
        dnd = { shadow = true; };
      };
    };
  };
}
