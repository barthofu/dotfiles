{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.misc;

  # Unbind/rebind the Logitech Lightspeed receiver (046d:c539) to simulate an
  # unplug/replug, since it comes up laggy after login until physically replugged.
  resetMouseDongle = pkgs.writeShellScriptBin "reset-mouse-dongle" ''
    set -euo pipefail
    for dev in /sys/bus/usb/devices/*; do
      if [ -f "$dev/idVendor" ] && [ -f "$dev/idProduct" ]; then
        if [ "$(cat "$dev/idVendor")" = "046d" ] && [ "$(cat "$dev/idProduct")" = "c539" ]; then
          port="$(basename "$dev")"
          echo "$port" > /sys/bus/usb/drivers/usb/unbind
          sleep 1
          echo "$port" > /sys/bus/usb/drivers/usb/bind
        fi
      fi
    done
  '';
in {
  options.module.misc = {
    enable = mkEnableOption "Enables misc";
  };

  config = mkIf cfg.enable {
    time.hardwareClockInLocalTime = true;
    
    services.logrotate.checkConfig = false;
    services.printing.enable = true;

    environment.pathsToLink = [ "/libexec" ];

    # Logitech Lightspeed receiver (046d:c539) auto-suspends and reacts with a
    # delay on login; keep it always powered so it doesn't need a replug.
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c539", TEST=="power/control", ATTR{power/control}="on"
    '';

    environment.systemPackages = [ resetMouseDongle ];

    # Allows the reset script to be run passwordless from the user session on login.
    security.sudo.extraRules = [{
      users = [ "bartho" ];
      commands = [{
        command = "${resetMouseDongle}/bin/reset-mouse-dongle";
        options = [ "NOPASSWD" ];
      }];
    }];

    console = {
      font = "Lat2-Terminus16";
      keyMap = "fr";
    };
  };
}