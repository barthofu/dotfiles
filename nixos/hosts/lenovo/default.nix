{ home-manager, pkgs, ... }:

{
  imports = [
    home-manager.nixosModules.home-manager

    ./hardware/hardware-configuration.nix
    ./hardware/audio.nix
    ./hardware/networking.nix
    ./hardware/touchpad.nix

    ./graphics/nvidia.nix
    ./graphics/opengl.nix
    ./graphical.nix # TODO: split in graphics/ and remove

    ./boot.nix
    ./fonts.nix
    ./locale.nix
    ./misc.nix
    ./packages.nix
    ./security.nix
    ./users.nix
    ./virtualization.nix
    ./console.nix
  ];

  system.stateVersion = "23.05";
}