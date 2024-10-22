{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.utils.cliphist;
	wofiEnabled = config.module.gui.wofi.enable;
in {
  options.module.utils.cliphist = {
    enable = mkEnableOption "Enables cliphist";
  };

  config = mkIf cfg.enable {
      
    home.packages = with pkgs; [
      cliphist
			(mkIf wofiEnabled (pkgs.callPackage ../../../../pkgs/cliphist-wofi-img {}))
    ];
  };
}