{ config, pkgs, ... }:

{
    imports = [
        ./gui
        ./programs
        ./terminal
    ];

    home = {
        username = "bartho";
        homeDirectory = "/home/bartho";
        stateVersion = "23.05";
    };

    programs.home-manager.enable = true;
}