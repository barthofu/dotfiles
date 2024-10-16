{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.terminal.navi;
in {
  options.module.terminal.navi = {
    enable = mkEnableOption "Enables navi";
  };

  config = mkIf cfg.enable {
    programs.navi = {
        enable = true;
    };
  };
}