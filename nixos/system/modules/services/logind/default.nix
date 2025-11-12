{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.logind;
in {
  options.module.services.logind = {
    enable = mkEnableOption "Enables logind service";
  };

  config = mkIf cfg.enable {
    services.logind = {
      settings = {
        Login = {
          HandleLidSwitch = "ignore";
          HandleLidSwitchExternalPower = "ignore";
          HandleLidSwitchDocked = "ignore";
        };
      };
    };

      # systemd.sleep.extraConfig = ''
      #   AllowSuspend=no
      #   AllowHibernation=no
      #   AllowHybridSleep=no
      #   AllowSuspendThenHibernate=no
      # '';
  };
}
