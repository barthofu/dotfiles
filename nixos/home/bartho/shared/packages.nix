{ pkgs, ... }:

{
    home.packages = with pkgs; [

        # Code
        gitkraken
        jetbrains-toolbox
        # postman # TODO: not working, should install it using flatpak instead
        insomnia
        starship
        python3

        # Web
        firefox

        # Media
        vlc
        spotify

        # Social
        discord
        teams-for-linux
        telegram-desktop
        signal-desktop

        # Utilities
        notion
        obsidian
        realvnc-vnc-viewer
        neatvnc
        cloudflare-warp
        rofi
        pywal
        calc
        networkmanager_dmenu
        # spotdl # spotify downloader # TODO: not working, find a fix or a correct working version
        scdl # soundcloud downloader
        feh # manage wallpapers

        # Misc

    ];
}
