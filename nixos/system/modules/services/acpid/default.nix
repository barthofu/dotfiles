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

        lid_state=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $NF}')
        if [ $lid_state = "closed" ]; then
            systemctl suspend &> /tmp/lid_event.log &
        fi
      '';
    };
  };
}
