{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    gh
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