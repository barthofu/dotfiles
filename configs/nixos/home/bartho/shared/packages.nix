{ pkgs, ... }:

{
    home.packages = with pkgs; [

        # Code
        gitkraken
        jetbrains-toolbox
        # postman # TODO: not working, should install it using flatpak instead
        insomnia
        starship

        # Web
        firefox
        google-chrome # TODO: eradicate my dependence on this shit

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
        nvtop # monitor GPU

        # CLI utilities
        jq # lightweight and flexible command-line JSON processor
        eza # modern replacement for ‘ls’
        fzf # command-line fuzzy finder
        zip
        xz
        unzip
        p7zip
        tree
        which
        file
        # spotdl # spotify downloader # TODO: not working, find a fix or a correct working version
        scdl # soundcloud downloader
        feh # manage wallpapers

        # Monitoring
        btop # replacement of htop/nmon
        iotop # io monitoring
        iftop # network monitoring

        # Misc
        cmatrix 
        neofetch
    ];
}