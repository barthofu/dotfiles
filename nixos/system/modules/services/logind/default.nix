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
      lidSwitch = "ignore";
      lidSwitchExternalPower = "ignore";
      lidSwitchDocked = "ignore";
    };

      # systemd.sleep.extraConfig = ''
      #   AllowSuspend=no
      #   AllowHibernation=no
      #   AllowHybridSleep=no
      #   AllowSuspendThenHibernate=no
      # '';
  };
}
