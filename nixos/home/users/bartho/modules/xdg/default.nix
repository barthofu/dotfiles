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
        "text/html" = "firefox.desktop";
        # "text/plain" = "emacs.desktop";
      };
    };
  };
}