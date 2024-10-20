{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.bluetooth;
in {
  options.module.bluetooth = {
    enable = mkEnableOption "Enables bluetooth";
    powerOnBoot = mkOption {
      type = types.bool;
      default = false;
      description = "Power on bluetooth on boot";
    };
  };

  config = mkIf cfg.enable {
    services.blueman.enable = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = cfg.powerOnBoot;
    };
  };
}