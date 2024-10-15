{ pkgs, ... }:

{
    home.packages = with pkgs; [
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
    ];
}