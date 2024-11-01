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
    hardware.pulseaudio = {
      enable = true;
      support32Bit = true;
    };

    nixpkgs.config.pulseaudio = true;
    
    # daemon useful for wine, pipewire, pulseaudio, etc
    security.rtkit.enable = true;
    
    services.pipewire = {
      enable = false;
      # alsa.enable = true;
      # alsa.support32Bit = true;
      # pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pavucontrol # gui sound mixer
      pamixer
    ];
  };
}