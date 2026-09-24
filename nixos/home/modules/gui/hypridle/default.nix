{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.gui.hypridle;

  timeoutOption = description: default: mkOption {
    type = types.nullOr types.ints.positive;
    inherit default description;
  };

  # Linux reports adapter types such as Mains and USB_C in power_supply.
  # Battery supplies are intentionally not considered external power sources.
  checkAcPower = pkgs.writeShellScriptBin "hypridle-check-ac" ''
    power_types=(${concatMapStringsSep " " escapeShellArg cfg.acPowerTypes})
    for supply in /sys/class/power_supply/*; do
      [ -d "$supply" ] || continue
      [ -r "$supply/type" ] && [ -r "$supply/online" ] || continue
      read -r supply_type < "$supply/type"
      read -r online < "$supply/online"
      [ "$online" = "1" ] || continue
      for power_type in "''${power_types[@]}"; do
        [ "$supply_type" = "$power_type" ] && exit 0
      done
    done
    exit 1  # AC is not connected (on battery)
  '';

  hasExternalMonitor = pkgs.writeShellScriptBin "hypridle-has-external-monitor" ''
    internal_prefixes=(${concatMapStringsSep " " escapeShellArg cfg.internalConnectorPrefixes})
    for status_file in /sys/class/drm/card*-*/status; do
      [ -r "$status_file" ] || continue
      read -r connection_status < "$status_file"
      [ "$connection_status" = "connected" ] || continue
      connector="''${status_file%/status}"
      connector="''${connector##*/}"
      is_internal=0
      for prefix in "''${internal_prefixes[@]}"; do
        case "$connector" in
          "$prefix"*) is_internal=1; break ;;
        esac
      done
      [ "$is_internal" -eq 0 ] && exit 0
    done
    exit 1
  '';

  renderListener = { timeout, command, resume ? null }:
    if timeout == null then "" else ''
      listener {
          timeout = ${toString (timeout * 60)}
          on-timeout = ${command}
      ${optionalString (resume != null) "    on-resume = ${resume}\n"}}
    '';

  renderConfig = timeouts: ''
    general {
        lock_cmd = pidof hyprlock || hyprlock
        before_sleep_cmd = hyprlock
        after_sleep_cmd = hyprctl dispatch dpms on && $HOME/.config/waybar/launch.sh
    }

    ${renderListener {
      timeout = timeouts.brightness;
      command = "brightnessctl -s set 10";
      resume = "brightnessctl -r";
    }}
    ${renderListener {
      timeout = timeouts.brightness;
      command = "brightnessctl -sd rgb:kbd_backlight set 0";
      resume = "brightnessctl -rd rgb:kbd_backlight";
    }}
    ${renderListener {
      timeout = timeouts.lock;
      command = "hyprlock";
    }}
    ${renderListener {
      timeout = timeouts.suspend;
      command = "$HOME/.local/scripts/power.sh suspend";
    }}
  '';

  # hypridle auto-discovers hypridle.conf under ~/.config/hypr.
  generateHypridleConfig = pkgs.writeShellScriptBin "hypridle-gen-config" ''
    config_dir="$HOME/.config/hypr"
    config_file="$config_dir/hypridle.conf"
    mkdir -p "$config_dir"
    if ${checkAcPower}/bin/hypridle-check-ac; then
      if ${hasExternalMonitor}/bin/hypridle-has-external-monitor; then
        profile=${escapeShellArg (renderConfig cfg.timeouts.docked)}
      else
        profile=${escapeShellArg (renderConfig cfg.timeouts.ac)}
      fi
    else
      profile=${escapeShellArg (renderConfig cfg.timeouts.battery)}
    fi
    printf '%s\n' "$profile" > "$config_file.tmp"
    mv "$config_file.tmp" "$config_file"
  '';

  monitorAndReload = pkgs.writeShellScriptBin "hypridle-monitor-power-state" ''
    last_state=""
    while true; do
      if ${checkAcPower}/bin/hypridle-check-ac; then
        if ${hasExternalMonitor}/bin/hypridle-has-external-monitor; then
          current_state="docked"
        else
          current_state="ac"
        fi
      else
        current_state="battery"
      fi

      if [ "$current_state" != "$last_state" ]; then
        ${generateHypridleConfig}/bin/hypridle-gen-config
        if [ -n "$last_state" ]; then
          systemctl --user restart hypridle.service || true
        fi
        last_state="$current_state"
      fi
      sleep ${toString cfg.pollInterval}
    done
  '';

in {
  options.module.gui.hypridle = {
    enable = mkEnableOption "Enables hypridle";
    pollInterval = mkOption {
      type = types.ints.positive;
      default = 10;
      description = "Power and external-monitor detection interval, in seconds.";
    };
    acPowerTypes = mkOption {
      type = types.listOf types.str;
      default = [ "Mains" "USB" "USB_C" "USB_PD" "USB_PD_DRP" "USB_ACA" "Wireless" ];
      description = "Linux power_supply type values treated as connected AC power.";
    };
    internalConnectorPrefixes = mkOption {
      type = types.listOf types.str;
      default = [ "eDP-" "EDP-" "LVDS-" "DSI-" ];
      description = "DRM connector-name prefixes treated as built-in displays, not a dock.";
    };
    timeouts = {
      ac = {
        brightness = timeoutOption "AC brightness dim timeout in minutes; null disables it." 45;
        lock = timeoutOption "AC lock timeout in minutes; null disables it." 60;
        suspend = timeoutOption "AC suspend timeout in minutes; null disables it." 90;
      };
      docked = {
        brightness = timeoutOption "Docked brightness dim timeout in minutes; null disables it." null;
        lock = timeoutOption "Docked lock timeout in minutes; null disables it." 60;
        suspend = timeoutOption "Docked suspend timeout in minutes; null disables it." null;
      };
      battery = {
        brightness = timeoutOption "Battery brightness dim timeout in minutes; null disables it." 15;
        lock = timeoutOption "Battery lock timeout in minutes; null disables it." 20;
        suspend = timeoutOption "Battery suspend timeout in minutes; null disables it." 30;
      };
    };
  };

  config = mkIf cfg.enable {
    # Disable home-manager's automatic hypridle service to use our custom one
    services.hypridle.enable = false;

    # Custom hypridle systemd user service
    systemd.user.services.hypridle = {
      Unit = {
        Description = "Hyprland idle daemon with AC/battery aware timeouts";
        After = [ "graphical-session.target" "hypridle-ac-monitor.service" ];
        Requires = [ "hypridle-ac-monitor.service" ];
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

    # Generate the initial profile before hypridle starts, then watch for changes.
    systemd.user.services.hypridle-ac-monitor = {
      Unit = {
        Description = "Monitor power and dock state for hypridle";
        Before = [ "hypridle.service" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStartPre = "${generateHypridleConfig}/bin/hypridle-gen-config";
        ExecStart = "${monitorAndReload}/bin/hypridle-monitor-power-state";
        Restart = "on-failure";
        RestartSec = 5;
      };
    };

    home.packages = [
      pkgs.hypridle
      checkAcPower
      hasExternalMonitor
      generateHypridleConfig
      monitorAndReload
    ];
  };
}