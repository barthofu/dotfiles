{ pkgs, ... }:

{
    home.packages = with pkgs; [

        # Code
        # vscodium
        # vim
        # git

        # # Browser
        # firefox
        # chromium
        # qutebrowser

        # Utilities
        jq # A lightweight and flexible command-line JSON processor
        exa # A modern replacement for ‘ls’
        fzf # A command-line fuzzy finder
        zip
        xz
        unzip
        p7zip
        tree
        which
        file

        # Monitoring
        btop # replacement of htop/nmon
        iotop # io monitoring
        iftop # network monitoring

        # Misc
        cmatrix 
        neofetch

        # Media
        vlc

        # # Messaging
        discord
        # telegram-desktop
        # signal-desktop

    ];
}