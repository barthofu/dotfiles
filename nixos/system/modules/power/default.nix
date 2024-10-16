{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.power;
in {
  options = {
    module.power = {
      enable = mkEnableOption "Enables power";
    };
  };

  config = mkIf cfg.enable {
    services = {
      power-profiles-daemon.enable = !config.services.tlp.enable;
      thermald.enable = true;
      tlp = {
        enable = true;
        # settings = {
        #     # Platform
        #     PLATFORM_PROFILE_ON_BAT = "low-power";
        #     PLATFORM_PROFILE_ON_AC = "perfomance";
                
        #     # Processor
        #     CPU_SCALING_MAX_FREQ_ON_AC = 3200000;
        #     CPU_BOOST_ON_BAT = 0;
        #     CPU_BOOST_ON_AC = 1;
        #     CPU_HWP_DYN_BOOST_ON_BAT = 0;
        #     CPU_HWP_DYN_BOOST_ON_AC = 1;
        # };
      };
    };
  };
}