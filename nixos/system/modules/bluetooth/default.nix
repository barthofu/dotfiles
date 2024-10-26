{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.bluetooth;
in {
  options.module.bluetooth = {
    enable = mkEnableOption "Enables bluetooth";
    powerOnBoot = mkOption {
      type = types.bool;
      default = false;
      description = "Power on bluetooth on boot";
    };
  };

  config = mkIf cfg.enable {
    services.blueman.enable = true;

    environment.systemPackages = with pkgs; [
      bluez
      overskride # bluetooth gui
    ];

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = cfg.powerOnBoot;
      settings = {
        General = {
          Experimental = true;
          # Enable A2DP sink and source for modern bluetooth headsets
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };

    # using Bluetooth headset buttons to control media player
    systemd.user.services.mpris-proxy = {
      description = "Mpris proxy";
      after = [ "network.target" "sound.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };
  };
}