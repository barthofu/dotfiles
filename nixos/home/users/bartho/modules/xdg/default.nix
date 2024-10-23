{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.user.xdg;
in {
  options.module.user.xdg = {
    enable = mkEnableOption "Enables xdg";
  };

  config = mkIf cfg.enable {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "default-web-browser" = "firefox.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "text/xml" = "firefox.desktop";
        "x-scheme-handler/ftp" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        # "text/plain" = "emacs.desktop";
      };
    };
  };
}
