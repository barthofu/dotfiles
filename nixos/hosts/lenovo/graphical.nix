{ pkgs, callPackage, ... }:

{


  # DE / WM
  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    
    enable = true;

    layout = "fr";
    xkbVariant = "azerty";
    # dpi = 140;
    
    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
      ];
    };    
  };

  # Compositor
  services.picom = {
    enable = true;

    backend = "glx";
    vSync = true;
    
    fade = true;
    
    activeOpacity = 1;
    inactiveOpacity = 0.9;
    opacityRules = [ "100:class_g *?= 'Rofi'" ];

    shadow = true;
    shadowOpacity = 0.8;
    # shadowOffsets = [
    #   -10 
    #   -15 
    # ];

    settings = {
      corner-radius = 12;
      blur = {
        method = "gaussian";
        size = 10;
        deviation = 5.0;
      };
      wintypes = {
        dropdown_menu = { shadow = false; };
        utility       = { shadow = false; };
        dock          = { shadow = false; };
      };
    };
  };

  # services.xserver.displayManager.setupCommands = ''
  #   LAPTOP_SCREEN='eDP-1'
  #   ${pkgs.xorg.xrandr}/bin/xrandr --output $LAPTOP_SCREEN --scale 0.8x0.8
  # '';
}