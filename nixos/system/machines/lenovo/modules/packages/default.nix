{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # CLI utilities
    # =======================
    ncdu # disk usage analyzer
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
    direnv # environment switcher

    # Monitoring
    # =======================
    htop
    btop
    gotop
    iotop # io monitoring
    iftop # network monitoring
    powertop # power consumption monitoring
    nvtopPackages.full # GPU monitoring
  ];
}