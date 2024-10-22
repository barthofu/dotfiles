{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.docker;
in {
  options.module.docker = {
    enable = mkEnableOption "Enables docker";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    virtualisation.docker.enableOnBoot = true;
  };
}