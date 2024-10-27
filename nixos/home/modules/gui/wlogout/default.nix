{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.gui.wlogout;
in {
  options.module.gui.wlogout = {
    enable = mkEnableOption "Enables wlogout";
  };

  config = mkIf cfg.enable {
      
    programs.wlogout = {
      enable = true;
    };
  };
}