{ lib
, config
, wm
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.programs.xdg-portal;
in {
  options.module.programs.xdg-portal = {
    enable = mkEnableOption "Enables xdg-portal";
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

      config = {
        common = {
          default = "*";

          "org.freedesktop.impl.portal.Screencast" = wm;
          "org.freedesktop.impl.portal.Screenshot" = wm;
        };
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
  };
}