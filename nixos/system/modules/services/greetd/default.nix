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
  hyprlandPkg = import ../../../../lib/hyprland.nix { inherit inputs pkgs; };

  cmd = if wm == "hyprland"
    then "${hyprlandPkg}/bin/Hyprland"
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

      settings = {
        # initial_session is a one-shot autologin (guarded by greetd's runfile):
        # it only ever runs once per boot. default_session must be a real
        # greeter that speaks the greetd IPC protocol (create_session/
        # start_session), otherwise greetd treats its exit as
        # "greeter exited without creating a session" and shuts itself down
        # entirely on the *second* logout of a boot, leaving a dead screen.
        initial_session = {
          user = username;
          command = cmd;
        };
        default_session = {
          command = "${pkgs.greetd}/bin/agreety --cmd '${cmd}'";
        };
      };
    };
  };
}