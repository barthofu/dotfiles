{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.terminal.zsh;
in {
  options.module.terminal.zsh = {
    enable = mkEnableOption "Enables zsh";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ 
          "git"
        ];
        theme = "robbyrussell";
      };
    };
  };
}