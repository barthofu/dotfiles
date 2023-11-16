{ config, pkgs, ... }:

{
    imports = [
        ./programs
        ./packages.nix
        ./flatpaks.nix
    ];

    home = {
        username = "bartho";
        homeDirectory = "/home/bartho";
        stateVersion = "23.05";
    };

    programs.home-manager.enable = true;
}