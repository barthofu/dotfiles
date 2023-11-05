{ config, pkgs, ... }:

{

    home.username = "bartho";
    home.homeDirectory = "/home/bartho";
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;

    home.packages = with pkgs; [

        # Code
        vscodium
        vim
        git

        # Browser
        firefox
        chromium
        qutebrowser

        # CLI
        cmatrix
        neofetch

        # Media
        vlc

        # Messaging
        discord
        telegram-desktop
        signal-desktop

    ];
}