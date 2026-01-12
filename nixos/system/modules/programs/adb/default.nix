{ inputs
, lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.programs.adb;
in {
  options.module.programs.adb = {
    enable = mkEnableOption "Enables adb";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      android-tools
    ];
  };
}