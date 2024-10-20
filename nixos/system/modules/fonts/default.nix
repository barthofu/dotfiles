{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.fonts;
in {
  options.module.fonts = {
    enable = mkEnableOption "Enables fonts";
  };

  config = mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = false;

      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        maple-mono
        font-awesome
        nerdfonts
        kanji-stroke-order-font
        liberation_ttf
        fira-sans
      ];

      fontconfig = {
        defaultFonts = {
          serif = [ "Noto Serif CJK JP" "Noto Serif" ];
          sansSerif = [ "Noto Sans CJK JP" "Noto Sans" ];
          monospace = [ "Noto Mono CJK JP" "Noto Mono" ];
        };

        allowBitmaps = false;
      };
    };
  };
}