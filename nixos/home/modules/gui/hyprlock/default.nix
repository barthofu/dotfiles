{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.gui.hyprlock;
	variant = "dark";
	font_family = "Inter";
in {
  options.module.gui.hyprlock = {
    enable = mkEnableOption "Enables hyprlock";
  };

  config = mkIf cfg.enable {
    # security.pam.services.hyprlock = {};

    home.packages = with pkgs; [
      hyprlock
    ];

    programs.hyprlock = {
      enable = false;

      settings = {};

        # settings = {
        #     general = {
        #         disable_loading_bar = true;
        #         hide_cursor = false;
        #         no_fade_in = true;
        #     };

        #     background = [
        #         {
        #             monitor = "";
        #             path = "/home/bartho/.local/share/wallpapers/aesthetic/cyberpunk.jpg";
        #         }
        #     ];

        #     # input-field = [
        #     #     {
        #     #         monitor = "eDP-1";

        #     #         size = "300, 50";

        #     #         outline_thickness = 1;

        #     #         outer_color = "rgb(${c.primary})";
        #     #         inner_color = "rgb(${c.on_primary_container})";
        #     #         font_color = "rgb(${c.primary_container})";

        #     #         fade_on_empty = false;
        #     #         placeholder_text = ''<span font_family="${font_family}" foreground="##${c.primary_container}">Password...</span>'';

        #     #         dots_spacing = 0.2;
        #     #         dots_center = true;
        #     #     }
        #     # ];

        #     # label = [
        #     #     {
        #     #         monitor = "";
        #     #         text = "$TIME";
        #     #         inherit font_family;
        #     #         font_size = 50;
        #     #         color = "rgb(${c.primary})";

        #     #         position = "0, 150";

        #     #         valign = "center";
        #     #         halign = "center";
        #     #     }
        #     #     {
        #     #         monitor = "";
        #     #         text = "cmd[update:3600000] date +'%a %b %d'";
        #     #         inherit font_family;
        #     #         font_size = 20;
        #     #         color = "rgb(${c.primary})";

        #     #         position = "0, 50";

        #     #         valign = "center";
        #     #         halign = "center";
        #     #     }
        #     # ];
        # };
    };
  };
}