{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.gui.wofi;
in {
  options.module.gui.wofi = {
    enable = mkEnableOption "Enables wofi";
  };

  config = mkIf cfg.enable {
    programs.wofi = {
      enable = true;
    #   settings = {
    #     location = "center";
    #     allow_markup = true;
    #     width = 250;
    #     pre_display_exec = true;
    #   };
    #   style = ''
    #     * {
    #       font-family: monospace;
    #     }
        
    #     window {
    #       background-color: #1c1c1c;
    #     }
    #   '';
    };
  };
}