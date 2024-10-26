{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.location;
in {
  options.module.location = {
    enable = mkEnableOption "Enables location";
  };

  config = mkIf cfg.enable {
    location.provider = "geoclue2";
    services.geoclue2.enable = true;
  };
}