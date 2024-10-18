{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.gnome;
in {
  options = {
    module.services.gnome.enable = mkEnableOption "Enables gnome services";
  };

  config = mkIf cfg.enable {
    services.gnome = {
      gnome-keyring = {
        enable = true;
      };
    };
  };
}
