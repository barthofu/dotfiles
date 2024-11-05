{ config
, lib
, pkgs
, pkgs-master
, isWorkstation
, wmEnable
, hyprlandEnable ? false
, ...
}:

with lib;

let
  inherit (pkgs.stdenv) isLinux;
  cfg = config.module.user.packages;
  
  isWayland = isLinux && isWorkstation && hyprlandEnable;
in {
  options.module.user.packages = {
    enable = mkEnableOption "Enables user packages";
  };

  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [

      # Dev & tools
      # =======================
      go # golang
      python3 # python

      # CLI utilities
      # =======================
      networkmanager_dmenu # dmenu frontend for networkmanager
      brightnessctl # cli to control brightness
      
      # Misc
      # =======================
      cmatrix # just flexin u know
      pipes # flex part 2
      lolcat # colorize output
      figlet # ascii art
      toilet # ascii art
      fortune # fortune teller
      cowsay # cow ascii art

    ] ++ lib.optionals isWorkstation [

      # Dev & tools
      # =======================
      jdk21 # java
      cargo # rust
      rustc # rust
      nodejs_22 # node
      nodePackages.pnpm # node package manager
      d2 # modern diagram scripting language

      gh # github cli
      kubectl # kubernetes cli
      kubernetes-helm # kubernetes package manager
      k9s # kubernetes tui
      kustomize # kubernetes config manager
      packer # image builder
      terraform # infrastructure as code
      pulumi-bin # infrastructure as code
      ansible # automation
      git-crypt # encrypt git repos
      coder # coder cli client
      
      gitkraken # git gui
      jetbrains-toolbox # jetbrains ide manager
      insomnia # rest client

      # Media
      # =======================
      vlc # media player
      spotify # music player
      jellyfin-media-player # jellyfin media player
      qbittorrent # torrent client

      # Social
      # =======================
      pkgs-master.vesktop # discord
      teams-for-linux # microsoft teams
      telegram-desktop # telegram
      signal-desktop # signal
      
      # Utilities
      # =======================
      notion # note taking
      obsidian # note taking
      realvnc-vnc-viewer # vnc client
      neatvnc # vnc server
      spacedrive # file manager
      nemo # file manager
      nautilus # file manager
      smile # emoji picker
      grim # screenshot
      slurp # select screen area
      spotdl # spotify downloader
      scdl # soundcloud downloader
      ffmpeg # media processing
      networkmanagerapplet # network manager applet
      qdirstat # disk usage analyzer
      todoist-electron # task list
      todoist # cli client for todoist
      kolourpaint # paint
      gimp # image editor
      inkscape # vector editor
      krita # digital painting
      udiskie # automount

      # Web
      # =======================
      chromium # web browser

      # Games
      # =======================
      steam # game client
      prismlauncher # minecraft open source launcher 

      # Office
      # =======================
      onlyoffice-bin # office suite

      # Misc
      # =======================
      cavalier # cava frontend
      starfetch # constellations fetcher
      octofetch # github stats fetcher
      zathura # document viewer

    ] ++ lib.optionals isWayland [

      # Wayland
      # =======================
      wl-clipboard # clipboard manager for wayland
      wl-screenrec # screen recorder for wayland
      wlr-randr # screen layout manager for wayland
      wlsunset # wayland screen dimmer
      wttrbar # wayland weather bar
      waybar # wayland bar
      hypridle # wayland idle manager
      hyprpicker # wayland color picker
      xdg-utils # wayland xdg-utils
      libinput-gestures # touchpad gestures
      wmctrl # libinput-gestures dependency
      xdotool # libinput-gestures dependency
      ydotool # libinput-gestures dependency
      pywal # color scheme generator
      # wl-ocr TODO: needs a derivation
    ];
  };
}
