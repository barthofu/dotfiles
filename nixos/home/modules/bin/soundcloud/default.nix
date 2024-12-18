{ config
, pkgs
, lib
, ...
}:

with lib;

let
  cfg = config.module.bin.soundcloud;
in {
  options.module.bin.soundcloud = {
    enable = mkEnableOption "Enables soundcloud";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
			(writeShellScriptBin "soundcloud" (builtins.readFile ./soundcloud.sh))
    ];
  };
}