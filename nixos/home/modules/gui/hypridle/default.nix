{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.gui.hypridle;
	variant = "dark";
	font_family = "Inter";
in {
  options.module.gui.hypridle = {
    enable = mkEnableOption "Enables hypridle";
  };

  config = mkIf cfg.enable {

    services.hypridle = {
      enable = true;
      
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";      # avoid starting multiple hyprlock instances.
          before_sleep_cmd = "hyprlock";                # lock before suspend.
          after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
        };

        listeners = [
          {
            timeout = 150;                          # 2.5min.
            on_timeout = "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
            on_resume = "brightnessctl -r";         # monitor backlight restore.
          }
          {
            timeout = 150;                                          # 2.5min.
            on_timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # turn off keyboard backlight.
            on_resume = "brightnessctl -rd rgb:kbd_backlight";        # turn on keyboard backlight.
          }
          {
            timeout = 600;           # 10min
            on_timeout = "hyprlock"; # lock screen using hyprlock.
          }
          {
            timeout = 750;                            # 12.5min
            on_timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
            on_resume = "hyprctl dispatch dpms on";   # screen on when activity is detected after timeout has fired.
          }
          {
            timeout = 3600;                   # 1hr
            on_timeout = "systemctl suspend"; # suspend pc
          }
        ];
      };
    };
  };
}