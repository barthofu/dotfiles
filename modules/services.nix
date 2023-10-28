{ ... }:

{
  services = {
    
    xserver = {
      enable = true;
      layout = "fr";
      displayManager.lightdm.enable = true;
      desktopManager.xfce.enable = true;
      libinput.touchpad.naturalScrolling = true;
    };
    
    printing = {
      enable: true;
    };
  };

} 