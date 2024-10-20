{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # CLI utilities
    jq # lightweight and flexible command-line JSON processor
    eza # modern replacement for ‘ls’
    fzf # command-line fuzzy finder
    zip # zip
    xz # xz
    unzip # unzip
    p7zip # 7z
    killall # kill processes by name
    tree # list contents of directories in a tree-like format
    which # locate a command
    file # determine file type
    just # command runner
    brightnessctl # cli to control brightness
    inotify-tools
    
    # Monitoring
    htop
    btop
    iotop # io monitoring
    iftop # network monitoring
    powertop # power consumption monitoring
    nvtopPackages.full # GPU monitoring
    
    # Utilities
    libinput-gestures # TODO: verify if really useful
    wmctrl # libinput-gestures dependency
    xdotool # libinput-gestures dependency
    direnv
    
    # Git
    git
    gh

    # Misc
    docker-compose
    krusader # file manager
    cmatrix # just flexin u know
    neofetch
    screenfetch
  ];
}