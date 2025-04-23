{ inputs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.programs.adb;
in {
  options.module.programs.adb = {
    enable = mkEnableOption "Enables adb";
  };

  config = mkIf cfg.enable {

    programs.adb = {
      enable = true;
    };
  };
}