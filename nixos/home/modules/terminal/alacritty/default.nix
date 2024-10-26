{ config
, pkgs
, lib
, ...
}:

with lib;

let
  cfg = config.module.terminal.alacritty;
in {
  options.module.terminal.alacritty = {
    enable = mkEnableOption "Enables alacritty";
  };

  config = mkIf cfg.enable {
      
    programs.alacritty = {
      enable = true;

      settings = {
        env = {
          TERM = "xterm-256color";
          TERMINAL = "alacritty";
        };

        shell = {
          program = "zsh";
          # args = [
          #   "-C"
          #   "pfetch"
          # ];
        };

        window = {
          padding.x = 20;
          padding.y = 20;
          decorations = "buttonless";
          dynamic_padding = true;
        };

        colors = lib.attrsets.recursiveUpdate (import ./themes/one-dark.nix) {};
      };
    };

    home.packages = with pkgs; [
      ueberzug
    ];
  };
}