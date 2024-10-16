{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.terminal.alacritty;
in {
  options.module.terminal.alacritty = {
    enable = mkEnableOption "Enables alacritty";
  };

  config = mkIf cfg.enable {
      
    programs.alacritty = {
      enable = true;
    };
  };
}