{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.gui.swaybg;
in {
  options.module.gui.swaybg = {
    enable = mkEnableOption "Enables swaybg";
    wallpaper = mkOption {
      type = types.str;
      default = "";
      description = "The absolute path of the wallpaper to use";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swaybg
      waypaper
    ];
  };
}
