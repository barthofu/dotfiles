{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.web.firefox;
in {
  options.module.web.firefox = {
    enable = mkEnableOption "Enables firefox";
  };

  config = mkIf cfg.enable {
      
    home.packages = with pkgs; [
      firefox
    ];

    home.file.".mozilla/native-messaging-hosts" = {
      recursive = true;
      source = let
        nativeMessagingHosts = with pkgs; [
          firefoxpwa
        ];
      in pkgs.runCommandLocal "native-messaging-hosts" { } ''
        mkdir $out
        for ext in ${toString nativeMessagingHosts}; do
            ln -sLt $out $ext/lib/mozilla/native-messaging-hosts/*
        done
      '';
    };
  };
}