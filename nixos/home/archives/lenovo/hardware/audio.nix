{ pkgs, ... }:

{

  # sound.enable = true;
  
  hardware.pulseaudio.enable = false;
  
  # daemon useful for wine, pipewire, pulseaudio, etc
  security.rtkit.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}