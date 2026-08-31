{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.misc;
in {
  options.module.misc = {
    enable = mkEnableOption "Enables misc";
  };

  config = mkIf cfg.enable {
    time.hardwareClockInLocalTime = true;
    
    services.logrotate.checkConfig = false;
    services.printing.enable = true;

    environment.pathsToLink = [ "/libexec" ];

    # Logitech Lightspeed receiver (046d:c539) auto-suspends and reacts with a
    # delay on login; keep it always powered so it doesn't need a replug.
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c539", TEST=="power/control", ATTR{power/control}="on"
    '';

    console = {
      font = "Lat2-Terminus16";
      keyMap = "fr";
    };
  };
}