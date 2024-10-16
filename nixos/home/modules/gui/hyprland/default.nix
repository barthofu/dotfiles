{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.gui.hyprland;
in {
  imports = [
    ./binds.nix
    ./settings.nix
  ];

  options.module.gui.hyprland = {
    enable = mkEnableOption "Enables hyprland";
  };

  config = mkIf cfg.enable {

    wayland.windowManager.hyprland = {
      enable = true;

      xwayland.enable = true;

      # plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
      #     hyprbars
      #     hyprexpo
      # ];

      # systemd = {
      #     variables = ["--all"];
      #     extraCommands = [
      #         "systemctl --user stop graphical-session.target"
      #         "systemctl --user start hyprland-session.target"
      #     ];
      # };
  };
  };
}