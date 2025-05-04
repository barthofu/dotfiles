{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.polkit;
in {
  options.module.services.polkit = {
    enable = mkEnableOption "Enables polkit service";
  };

  config = mkIf cfg.enable {
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (
          subject.isInGroup("users")
            && (
              action.id == "org.freedesktop.login1.reboot" ||
              action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
              action.id == "org.freedesktop.login1.power-off" ||
              action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||
              action.id == "org.freedesktop.login1.suspend" ||
              action.id == "org.freedesktop.login1.suspend-multiple-sessions" ||
              action.id == "org.freedesktop.login1.hibernate" ||
              action.id == "org.freedesktop.login1.hibernate-multiple-sessions"
            )
          )
        {
          return polkit.Result.YES;
        }

        if (
          subject.isInGroup("wheel") 
            && (
              action.id == "org.freedesktop.policykit.exec" ||
              action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
              action.id == "org.freedesktop.udisks2.drive-eject" ||
              action.id == "org.freedesktop.udisks2.filesystem-mount"
            )
          ) 
        {
          return polkit.Result.YES;
        }
      })
    '';
  };
}
