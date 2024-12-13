{ pkgs
, lib
, config
, isWorkstation 
, ... 
}:

with lib;

let
  cfg = config.module.packages;
in {
  options.module.packages = {
    enable = mkEnableOption "Enables system packages";
  };

  config = mkIf cfg.enable {

    services.teamviewer.enable = true;

    environment.systemPackages = with pkgs; [

      # CLI utilities
      # =======================
      vim # vim
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
      bat # cat with wings
      fastfetch # system info
      pfetch-rs # system info
      neofetch # system info
      screenfetch # system info
      ipfetch # ip fetcher
      cpufetch # cpu fetcher
      ramfetch # ram fetcher

      # Hardware utils
      # =======================
      glxinfo # display info about a GLX extension
      pciutils # lspci
      usbutils # lsusb
      lm_sensors # sensors
      strace # trace system calls and signals
      ltrace # library call tracer
      lsof # list open ports
      sysstat # sar
      cpufetch # cpu info
      sbctl # system boot control
      geekbench # benchmark

      # Network
      # =======================
      inetutils # ping, telnet, etc.
      wireguard-tools # wireguard
      dig # dns lookup
      nmap # network scanner
      dnsutils # dig, nslookup
      iperf3 # network bandwidth testing
      mtr # network diagnostic tool
      ipcalc # ip calculator
      cacert # ca certificates
      speedtest-cli # speedtest
      speedtest-rs # speedtest

      # Monitoring
      # =======================
      htop
      btop
      bottom
      gotop
      iotop # io monitoring
      iftop # network monitoring
      powertop # power consumption monitoring
      nvtopPackages.full # GPU monitoring
      zfxtop # all-in-one monitoring
      powerstat # power consumption monitoring

      # To sort cli
      gping
      fd
    
    ] ++ lib.optionals isWorkstation [

      # Hardware utils
      # =======================
      smartmontools # monitor hard drive health
      hdparm # hard drive performance
      microcodeIntel # intel cpu microcode
      libGL # opengl
      libva-utils # vaapi
      intel-gpu-tools # intel gpu tools
      fwupd # firmware updates
      fwupd-efi # firmware updates
      iwgtk # wifi gui

      # Utils
      # =======================
      dconf-editor # direct editing of dconf settings
      monitorets # system resources
      resources # system resources
      gedit # text editor

      # To sort gui

    ];
  };
}