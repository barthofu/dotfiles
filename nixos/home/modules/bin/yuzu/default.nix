{ config
, pkgs
, lib
, ...
}:

with lib;

let
  cfg = config.module.bin.yuzu;
in {
  options.module.bin.yuzu = {
    enable = mkEnableOption "Enables yuzu";
  };

  config = mkIf cfg.enable {

    xdg.desktopEntries = {
      yuzu = {
        name = "Yuzu";
        comment = "Nintendo Switch Emulator";
        exec = "yuzu";
        icon = "Yuzu";
        categories = [ "Application" "Game" "Emulator" ];
        mimeType = [ "application/x-nx-nca" "application/x-nx-nro" "application/x-nx-nso" "application/x-nx-nsp" "application/x-nx-xci" ];
        settings = {
          Keywords = "Switch;Nintendo;Emulator";
          StartupWMClass = "Yuzu";
        };
      };
    };

    home.packages = with pkgs; [
			(writeShellScriptBin "yuzu" ''
        #!/bin/sh
        YUZU_APPIMAGE=${pkgs.lib.escapeShellArg "${./yuzu-ea-4176.AppImage}"}
        appimage-run $YUZU_APPIMAGE "$@" &
      '')
    ];
  };
}