{ config
, lib
, pkgs
, inputs
, platform
, username
, homeDirectory
, ...
}:

with lib;

let
  cfg = config.module.utils.winapps;
in {
  options.module.utils.winapps = {
    enable = mkEnableOption "Enables winapps";
  };

  config = mkIf cfg.enable {
      
    home.packages = with pkgs; [
      inputs.winapps.packages."${platform}".winapps
      inputs.winapps.packages."${platform}".winapps-launcher
      freerdp3
    ];

    home.file.".config/winapps/compose.yaml".text = ''${
      (import ./templates/compose.nix { inherit username homeDirectory; })
    }'';

    home.file.".config/winapps/winapps.conf".text = ''${
      (import ./templates/conf.nix { inherit username; })
    }'';
  };
}