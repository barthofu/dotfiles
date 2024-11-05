{ pkgs
, lib
, config
, username
, inputs
, wm
, ...
}:

with lib;

let
  cfg = config.module.services.greetd;

  cmd = if wm == "hyprland"
    then "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland"
  else "";
in {
  options.module.services.greetd = {
    enable = mkEnableOption "Enables greetd";
  };

  config = mkIf cfg.enable {
    # security.pam.services.greetd = {
    #   enableGnomeKeyring = true;
    # };

    services.greetd = {
      enable = true;
      vt = 1;

      settings = rec {
        initial_session = { # triggers the autologin
          user = username;
          command = cmd;
        };
        default_session = initial_session;
      };
    };
  };
}