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

      # xdg-desktop-portal-wlr deliberately excluded: it conflicts with the
      # Hyprland-native portal (programs.hyprland.portalPackage) for the
      # Screencast/Screenshot interfaces, causing unstable PipeWire DMA-BUF
      # negotiation (EGL_BAD_MATCH renegotiation loops during screen sharing).
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };
}