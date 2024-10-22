{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.utils.cliphist;
in {
  options.module.utils.cliphist = {
    enable = mkEnableOption "Enables cliphist";
  };

  config = mkIf cfg.enable {
      
    home.packages = with pkgs; [
      cliphist
			(mkIf wofiEnabled (pkgs.callPackage ../../../../pkgs/cliphist-wofi-img {}))
    ];

		home.files = {
			".local/scripts/cliphist.sh" = {
				text = ''
					#!/bin/sh
					cliphist list | wofi --dmenu --allow-images --pre-display-cmd "cliphist-wofi-img-go %s" | cliphist decode | wl-copy
				'';
				permissions = "0755";
			};
		};
  };
}