{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.terminal.kitty;
in {
  options.module.terminal.kitty = {
    enable = mkEnableOption "Enables kitty";
  };

  config = mkIf cfg.enable {
    
    programs.kitty = {
      enable = true;
      settings = {
        # font
        font_size = "12.0";
        disable_ligatures = "cursor";

        # window layout
        winwo_padding_width = 10;
        confirm_os_window_close = 0;
      };
    };
  };
}