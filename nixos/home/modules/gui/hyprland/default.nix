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
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      plugins = [
        inputs.hyprland-virtual-desktops.packages.${pkgs.system}.virtual-desktops
      ];

      extraConfig = ''
        source = ~/.config/hypr/hyprland-source.conf
      '' + ''
        ${if swayBgEnabled then "exec-once = swaybg -m fill -i ~/.local/share/wallpapers/${config.module.gui.swaybg.wallpaper}" else ""}
        ${if cliphistEnabled then "exec-once = cliphist wipe; wl-paste --watch cliphist store" else ""}
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

      # plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
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