{ config
, lib
, inputs
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.gui.hyprland;
  swayBgEnabled = config.module.gui.swaybg.enable;
  cliphistEnabled = config.module.utils.cliphist.enable;
in {
  options.module.gui.hyprland = {
    enable = mkEnableOption "Enables hyprland";
  };

  config = mkIf cfg.enable {

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      package = null;
      portalPackage = null;

      plugins = [
        inputs.hyprland-virtual-desktops.packages.${pkgs.stdenv.hostPlatform.system}.virtual-desktops
      ];

      extraConfig = ''
        source = ~/.config/hypr/hyprland-source.conf
      '' + ''
        ${if cliphistEnabled then "exec-once = cliphist wipe; wl-paste --watch cliphist store" else ""}
      '' + ''
        exec-once = /run/wrappers/bin/sudo -n /run/current-system/sw/bin/reset-mouse-dongle > /tmp/reset-mouse-dongle.log 2>&1
      '' + ''
        plugin {
          virtual-desktops {
            names = 1, 2, 3, 4, 5, 6, 7, 8, 9
            cycleworkspaces = 1
            rememberlayoput = size
            notifyinit = 0
            verbose_logging = 0
          }
        }
      '';

      # plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
      #     hyprbars
      #     hyprexpo
      # ];

      systemd = {
        variables = ["--all"];
        extraCommands = [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };
    };
  };
}
