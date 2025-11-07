{ config
, lib
, inputs
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.programs.obs-studio;
in {
  options.module.programs.obs-studio = {
    enable = mkEnableOption "Enables obs-studio";
  };

  config = mkIf cfg.enable {
      
		programs.obs-studio = {
			
			enable = true;

			package = (
				pkgs.obs-studio.override {
					cudaSupport = true;
				}
			);

			plugins = with pkgs.obs-studio-plugins; [
				wlrobs
				obs-backgroundremoval
				obs-pipewire-audio-capture
				obs-vkcapture
			]; 

			enableVirtualCamera = true;
		};
  };
}