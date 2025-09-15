{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.battery;
in {
  options.module.battery = {
    enable = mkEnableOption "Enables battery";
  };

  config = mkIf cfg.enable {
    services = {
      thermald.enable = true;
      system76-scheduler.settings.cfsProfiles.enable = true;
      
      # Power profiles daemon
      power-profiles-daemon.enable = !config.services.tlp.enable;
      
      # TLP
      auto-cpufreq.enable = config.services.tlp.enable;
      tlp = {
        enable = false;
        settings = {
          # Platform
          PLATFORM_PROFILE_ON_BAT = "powersave";
          PLATFORM_PROFILE_ON_AC = "perfomance";
              
          # Processor
          CPU_BOOST_ON_BAT = 0;
          CPU_BOOST_ON_AC = 1;
          CPU_HWP_DYN_BOOST_ON_BAT = 0;
          CPU_HWP_DYN_BOOST_ON_AC = 1;
        };
      };
    };
  };
}