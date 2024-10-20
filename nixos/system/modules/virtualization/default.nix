{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.virtualization;
in {
  options.module.virtualization = {
    enable = mkEnableOption "Enables virtualization";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    virtualisation.docker.enableOnBoot = true;
    # virtualisation.virtualbox.guest.enable = true;
    # virtualisation.virtualbox.guest.x11 = true;
  };
}