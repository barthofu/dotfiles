{ home-manager, pkgs, ... }:

{
  imports = [
    home-manager.nixosModules.home-manager

    ./hardware/hardware-configuration.nix
    ./hardware/audio.nix
    ./hardware/touchpad.nix

    ./graphics/nvidia.nix
    ./graphics/opengl.nix

    ./boot.nix
    ./fonts.nix
    ./locale.nix
    ./misc.nix
    ./networking.nix
    ./packages.nix
    ./security.nix
    ./users.nix
    ./virtualization.nix
  ];

  system.stateVersion = "23.05";
}
