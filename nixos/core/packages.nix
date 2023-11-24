{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [

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
    
    # System configuration
    brightnessctl # cli to control brightness
    pulseaudio # audio control
    pavucontrol # pipewire frontend
    arandr # gui for xrandr (monitors management)
    
    # Monitoring
    htop
    btop
    iotop # io monitoring
    iftop # network monitoring
    nvtop # GPU monitoring
    
    # Utilities
    libinput-gestures # TODO: verify if really useful
    direnv
    just # command runner
    
    # Git
    git
    gh

    # Misc
    docker-compose
    krusader # file manager
    cmatrix # just flexin u know
    neofetch
    
  ];

  # thunar
  programs.thunar.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
}