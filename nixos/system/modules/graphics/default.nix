{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.graphics;
in {
  options = {
    module.graphics = {
      enable = mkEnableOption "Enables graphics";
    };
  };

  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}