{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.terminal.zoxide;
in {
  options.module.terminal.zoxide = {
    enable = mkEnableOption "Enables zoxide";
  };

  config = mkIf cfg.enable {
    
    programs.zoxide = {
        enable = true;       
        enableZshIntegration = true;
    };
  };
}