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
        noto-fonts-color-emoji
        kanji-stroke-order-font
        julia-mono
        
        # nerdfonts
        maple-mono.NF-CN
        fira-sans
        liberation_ttf
        jetbrains-mono
        nerd-fonts.fira-code
        nerd-fonts.droid-sans-mono

        # icons
        font-awesome
        material-design-icons
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