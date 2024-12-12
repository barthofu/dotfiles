{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.gui.gtk;
in {
  options.module.gui.gtk = {
    enable = mkEnableOption "Enables gtk";
  };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      iconTheme = {
        name    = "kora";
        package = pkgs.kora-icon-theme;
      };
    };
  };
}
