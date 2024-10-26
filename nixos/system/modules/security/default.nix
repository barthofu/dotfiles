{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.security;
in {
  options.module.security = {
    enable = mkEnableOption "Enables security";
  };

  config = mkIf cfg.enable {

    # sudo     
    security.sudo.wheelNeedsPassword = false;

    # antivirus
    services.clamav = {
      daemon.enable = true;
      fangfrisch.enable = true;
      fangfrisch.interval = "daily";
      updater.enable = true; # keep the signatures' database updated
      updater.interval = "daily"; #man systemd.time
      updater.frequency = 12;
    };

    environment.systemPackages = with pkgs; [
      vulnix       # nix store vulnerability scanner (scan command: vulnix --system)
      clamav       # clamav antivirus client (scan command: sudo freshclam; clamscan [options] [file/directory/-])
      chkrootkit   # rootkit presence scanner (scan command: sudo chkrootkit)

      tomb        # encrypted storage
    ];

    # network
    networking.firewall = { # enable firewall and block all ports
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    services.fail2ban.enable = true; # block brute force attacks
    services.opensnitch.enable = true; # fine grained network control

    # firejail
    programs.firejail = {
      enable = true;
      wrappedBinaries = {
        firefox = {
          executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
          profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
        };
        chromium = {
          executable = "${pkgs.lib.getBin pkgs.chromium}/bin/chromium";
          profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
        };
      };
    };

    # disable coredump that could be exploited later
    # and also slow down the system when something crash
    systemd.coredump.enable = false;

    # login
    security.pam.services.hyprlock = {};

    # misc
    security.tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
  };
}