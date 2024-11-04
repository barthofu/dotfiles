{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.media.obs-studio;
in {
  options.module.media.obs-studio = {
    enable = mkEnableOption "Enables obs-studio";
  };

  config = mkIf cfg.enable {
      
		programs.obs-studio = {
			enable = true;
			plugins = with pkgs.obs-studio-plugins; [
				wlrobs
				obs-backgroundremoval
				obs-pipewire-audio-capture
			]; 
		};
  };
}