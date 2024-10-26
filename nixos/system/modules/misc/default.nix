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

    console = {
      font = "Lat2-Terminus16";
      keyMap = "fr";
    };
  };
}