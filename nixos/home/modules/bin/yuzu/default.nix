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
    home.packages = with pkgs; [
			(writeShellScriptBin "yuzu" ''
        #!/bin/sh
        YUZU_APPIMAGE=${pkgs.lib.escapeShellArg "${./yuzu-ea-4176.AppImage}"}
        appimage-run $YUZU_APPIMAGE "$@"
      '')
    ];
  };
}