{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.terminal.cava;
in {
  options.module.terminal.cava = {
    enable = mkEnableOption "Enables cava";
  };

  config = mkIf cfg.enable {
    programs.cava = {
      enable = true;

      settings = {
        color = {
          gradient = 2;
          gradient_color_1 = "'#ED333B'";
          gradient_color_2 = "'#2255D6'";
        };
      };
    };
  };
}