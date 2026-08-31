{ lib
, config
, pkgs
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

      # Bascule performance/balanced selon secteur/batterie -> courbe ventilo firmware plus agressive sur secteur
      udev.extraRules = mkIf config.services.power-profiles-daemon.enable ''
        SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"
        SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"
      '';
      
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