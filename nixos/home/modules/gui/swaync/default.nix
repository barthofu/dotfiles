{ config
, lib
, pkgs
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
    # services.swaync = {
    #   enable = true;
    # };
    home.packages = with pkgs; [
      swaynotificationcenter
      libnotify
      glib
    ];
  };
}