{ config
, pkgs
, lib
, ...
}:

with lib;

let
  cfg = config.module.bin.ping-monitor;
in {
  options.module.bin.ping-monitor = {
    enable = mkEnableOption "Enables ping-monitor";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
			(writeShellScriptBin "ping-monitor" (builtins.readFile ./ping-monitor.sh))
    ];
  };
}