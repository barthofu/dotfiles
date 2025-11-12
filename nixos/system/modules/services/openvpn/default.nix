{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.openvpn;
in {
  options.module.services.openvpn = {
    enable = mkEnableOption "Enables openvpn services";
  };

  config = mkIf cfg.enable {
    services.openvpn.servers = {
      pia-moldova = {
        config = ''  config /etc/vpn/pia-moldova.ovpn '';
        autoStart = false;
        updateResolvConf = false;
      };
      pia-france = {
        config = ''  config /etc/vpn/pia-france.ovpn '';
        autoStart = false;
        updateResolvConf = false;
      };
      pia-belgium = {
        config = ''  config /etc/vpn/pia-belgium.ovpn '';
        autoStart = false;
        updateResolvConf = false;
      };
      pia-germany = {
        config = ''  config /etc/vpn/pia-germany.ovpn '';
        autoStart = false;
        updateResolvConf = false;
      };
      pia-italy = {
          config = ''  config /etc/vpn/pia-italy.ovpn '';
          autoStart = false;
          updateResolvConf = false;
      };
      pia-japan = {
        config = ''  config /etc/vpn/pia-japan.ovpn '';
        autoStart = false;
        updateResolvConf = false;
      };
    };
  };
}
