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
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swaybg
      waypaper
    ];
  };
}
