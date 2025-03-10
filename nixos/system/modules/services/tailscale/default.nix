{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.services.tailscale;
in {
  options.module.services.tailscale = {
    enable = mkEnableOption "Enables tailscale";
  };

  config = mkIf cfg.enable {
      
    services.tailscale = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      tailscale-systray
    ];
  };
}