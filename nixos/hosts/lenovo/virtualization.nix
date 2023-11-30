{ pkgs, ... }:

{
    virtualisation.docker.enable = true;
    virtualisation.docker.enableOnBoot = true;
    # virtualisation.virtualbox.guest.enable = true;
    # virtualisation.virtualbox.guest.x11 = true;
} 