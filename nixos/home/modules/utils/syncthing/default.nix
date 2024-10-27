{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.utils.syncthing;
in {
  options.module.utils.syncthing = {
    enable = mkEnableOption "Enables syncthing";
  };

  config = mkIf cfg.enable {
      
    services.syncthing = {
      enable = true;
      tray = {
        enable = true;
        command = "syncthingtray --wait"; # add --wait
      };
    };

    home.packages = with pkgs; [
      syncthingtray
    ];
  };
}