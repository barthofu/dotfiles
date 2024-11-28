{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.acpid;
in {
  options.module.services.acpid = {
    enable = mkEnableOption "Enables acpid services";
  };

  config = mkIf cfg.enable {
    services.acpid = {
      enable = true;
      lidEventCommands =
        ''
          export PATH=$PATH:/run/current-system/sw/bin
          export WAYLAND_DISPLAY=wayland-1
          export XDG_RUNTIME_DIR=/run/user/1000

          INTERNAL_SCREEN="eDP-1"

          lid_state=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $NF}')
          external_monitor=$(hyprctl monitors | grep "Monitor" | grep -v "$INTERNAL_SCREEN" | awk '{print $2}' | head -n 1)

          if [ -n "$external_monitor" ] && [ $lid_state == "closed" ]; then
            hyprctl keyword monitor "$INTERNAL_SCREEN, disable"
          else
            hyprctl reload
          fi
        '';
    };
  };
}
