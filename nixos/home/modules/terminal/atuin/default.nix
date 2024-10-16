{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.terminal.atuin;
in {
  options.module.terminal.atuin = {
    enable = mkEnableOption "Enables atuin";
  };

  config = mkIf cfg.enable {
        
        programs.atuin = {
            enable = true;       
            enableZshIntegration = true;
        };
  };
}