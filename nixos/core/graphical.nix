{ config, pkgs, callPackage, ... }:

{

  # NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    open = false;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      # Make sure to use the correct Bus ID values for your system!
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # DE / WM
  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    
    enable = true;

    layout = "fr";
    xkbVariant = "azerty";
    dpi = 140;
    
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
    
    libinput.touchpad.naturalScrolling = false;
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