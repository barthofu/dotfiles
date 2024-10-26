{ inputs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.programs.thunar;
in {
  options.module.programs.thunar = {
    enable = mkEnableOption "Enables thunar";
  };

  config = mkIf cfg.enable {

    programs = {
      thunar.enable = true;
      xfconf.enable = true; # Required for thunar to save preferences and settings if not using xfce desktop environment
    };

    services = {
      tumbler.enable = true; # Thumbnail support for images
      gvfs.enable = true; # Mount, trash, and other functionalities
    };
  };
}