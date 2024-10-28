{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.gui.swaync;
in {
  options.module.gui.swaync = {
    enable = mkEnableOption "Enables swaync";
  };

  config = mkIf cfg.enable {
    services.swaync = {
      enable = true;
    };
  };
}