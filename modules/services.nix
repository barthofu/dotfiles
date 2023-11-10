{ pkgs, ... }:

{
  services = {
    
    xserver = {
      enable = true;
      layout = "fr";
      xkbVariant = "azerty";
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      libinput.touchpad.traditionalScrolling = true;
    };

    printing.enable = true;
  };

} 