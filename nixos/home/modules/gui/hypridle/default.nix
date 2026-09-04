{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.gui.hypridle;
  
  # Check if we're on AC power
  checkAcPower = pkgs.writeShellScriptBin "hypridle-check-ac" ''
    if [ -d "/sys/class/power_supply" ]; then
      for supply in /sys/class/power_supply/*/; do
        type_file="''${supply}type"
        online_file="''${supply}online"
        
        if [ -f "$type_file" ] && grep -q "AC" "$type_file"; then
          if [ -f "$online_file" ] && grep -q "1" "$online_file"; then
            exit 0  # AC is connected
          fi
        fi
      done
    fi
    exit 1  # AC is not connected (on battery)
  '';

  # Generate config file for hypridle based on power state.
  # hypridle only auto-discovers hypridle.conf under "~/.config/hypr" (its -c flag
  # is broken on this version and silently ignored), so it must live there.
  generateHypridleConfig = pkgs.writeShellScriptBin "hypridle-gen-config" ''
    config_dir="$HOME/.config/hypr"
    config_file="$config_dir/hypridle.conf"
    mkdir -p "$config_dir"
    
    if ${checkAcPower}/bin/hypridle-check-ac; then
      # AC mode - longer timeouts, no suspend
      cat > "$config_file" << 'EOH'
general {
    lock_cmd = pidof hyprlock || hyprlock
    before_sleep_cmd = hyprlock
    after_sleep_cmd = hyprctl dispatch dpms on && $HOME/.config/waybar/launch.sh
}

listener {
    timeout = 600
    on-timeout = brightnessctl -s set 10
    on-resume = brightnessctl -r
}

listener {
    timeout = 600
    on-timeout = brightnessctl -sd rgb:kbd_backlight set 0
    on-resume = brightnessctl -rd rgb:kbd_backlight
}

listener {
    timeout = 1800
    on-timeout = hyprlock
}

listener {
    timeout = 2100
    on-timeout = hyprctl dispatch dpms off
    on-resume = hyprctl dispatch dpms on
}
EOH
    else
      # Battery mode - shorter timeouts, suspend enabled
      cat > "$config_file" << 'EOH'
general {
    lock_cmd = pidof hyprlock || hyprlock
    before_sleep_cmd = hyprlock
    after_sleep_cmd = hyprctl dispatch dpms on && $HOME/.config/waybar/launch.sh
}

listener {
    timeout = 150
    on-timeout = brightnessctl -s set 10
    on-resume = brightnessctl -r
}

listener {
    timeout = 150
    on-timeout = brightnessctl -sd rgb:kbd_backlight set 0
    on-resume = brightnessctl -rd rgb:kbd_backlight
}

listener {
    timeout = 600
    on-timeout = hyprlock
}

listener {
    timeout = 750
    on-timeout = hyprctl dispatch dpms off
    on-resume = hyprctl dispatch dpms on
}

listener {
    timeout = 3600
    on-timeout = $HOME/.local/scripts/power.sh suspend
}
EOH
    fi
  '';

  # Monitor AC status and reload hypridle when it changes
  monitorAndReload = pkgs.writeShellScriptBin "hypridle-monitor-ac" ''
    last_state=""
    
    while true; do
      # Check current AC state
      if ${checkAcPower}/bin/hypridle-check-ac; then
        current_state="ac"
      else
        current_state="battery"
      fi
      
      # If state changed, regenerate config and reload hypridle
      if [ "$current_state" != "$last_state" ]; then
        ${generateHypridleConfig}/bin/hypridle-gen-config
        systemctl --user restart hypridle.service || true
        last_state="$current_state"
      fi
      
      # Check every 10 seconds
      sleep 10
    done
  '';

in {
  options.module.gui.hypridle = {
    enable = mkEnableOption "Enables hypridle";
  };

  config = mkIf cfg.enable {
    
    # Disable home-manager's automatic hypridle service to use our custom one
    services.hypridle.enable = false;

    # Custom hypridle systemd user service
    systemd.user.services.hypridle = {
      Unit = {
        Description = "Hyprland idle daemon with AC/battery aware timeouts";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.hypridle}/bin/hypridle";
        Restart = "on-failure";
        RestartSec = 5;
      };
    };

    # Monitor AC status and reload hypridle when it changes
    systemd.user.services.hypridle-ac-monitor = {
      Unit = {
        Description = "Monitor AC power and reload hypridle configuration";
        After = [ "hypridle.service" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStartPre = "${generateHypridleConfig}/bin/hypridle-gen-config";
        ExecStart = "${monitorAndReload}/bin/hypridle-monitor-ac";
        Restart = "on-failure";
        RestartSec = 5;
      };
    };

    home.packages = [ 
      pkgs.hypridle
      checkAcPower 
      generateHypridleConfig 
      monitorAndReload 
    ];
  };
}