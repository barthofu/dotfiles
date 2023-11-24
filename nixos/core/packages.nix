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
    krusader
    arandr
  ];

  # thunar
  programs.thunar.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
}