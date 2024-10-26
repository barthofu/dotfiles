{ config
, pkgs
, lib
, ...
}:

with lib;

let
  cfg = config.module.bin.meteo;
in {
  options.module.bin.meteo = {
    enable = mkEnableOption "Enables meteo";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
			(writeShellScriptBin "meteo" (builtins.readFile ./meteo.sh))
    ];
  };
}