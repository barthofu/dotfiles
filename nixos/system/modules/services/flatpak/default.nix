{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.flatpak;
in {
  options.module.services.flatpak = {
    enable = mkEnableOption "Enables flatpak service";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;
    };
  };
}
