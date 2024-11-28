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
    services.logind.extraConfig = ''
      lidSwitch = "ignore";
      lidSwitchExternalPower = "ignore";
      lidSwitchDocked = "ignore";
    '';
  };
}
