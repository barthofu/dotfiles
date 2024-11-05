{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.dbus;
in {
  options.module.services.dbus = {
    enable = mkEnableOption "Enables dbus service";
  };

  config = mkIf cfg.enable {
    services.dbus = {
      enable = true;
    };
  };
}
