{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.audio;
in {
  options.module.audio = {
    enable = mkEnableOption "Enables audio";
  };

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = false;
    
    # daemon useful for wine, pipewire, pulseaudio, etc
    security.rtkit.enable = true;
    
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pw-volume # pipewire volume control command line tool
      pavucontrol # pipewire frontend
    ];
  };
}