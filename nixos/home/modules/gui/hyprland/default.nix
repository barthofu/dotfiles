{ config
, lib
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

      extraConfig = ''
        source = ~/.config/hypr/hyprland-source.conf
        ${if swayBgEnabled then "exec-once = swaybg -i ~/.local/share/wallpapers/${config.module.gui.swaybg.wallpaper}" else ""}
        ${if cliphistEnabled then "exec-once = cliphist wipe; wl-paste --watch cliphist store" else ""}
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