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

      shellAliases = {
        "ls" = "ls -CF";
        "git" = "LANG=en_GB git";
        "ssh" = "TERM=xterm-256color ssh";
        "tf" = "terraform";
      };

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