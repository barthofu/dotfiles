{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.touchpad;
in {
  options.module.touchpad = {
    enable = mkEnableOption "Enables touchpad";
  };

  config = mkIf cfg.enable {
    services.libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = false;
        scrollMethod = "twofinger";
        disableWhileTyping = false;
      };
    };
  };
}