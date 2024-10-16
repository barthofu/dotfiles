{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.security;
in {
  options = {
    module.security = {
      enable = mkEnableOption "Enables security";
    };
  };

  config = mkIf cfg.enable {
    security.sudo.wheelNeedsPassword = false;
  };
}