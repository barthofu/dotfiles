{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.power;
in {
  options.module.power = {
    enable = mkEnableOption "Enables power";
  };

  config = mkIf cfg.enable {
    powerManagement = {
      enable = true;
      powertop.enable = true;
    };
  };
}