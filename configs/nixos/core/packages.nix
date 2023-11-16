{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    git
    just
    libinput-gestures
    direnv
    docker-compose
    brightnessctl # cli to control brightness
    pulseaudio # audio control
    pavucontrol # pipewire frontend
    htop
  ];
}