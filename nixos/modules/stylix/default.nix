{ pkgs
, lib
, self
, config
, hostname
, ...
}: 

with lib;

let
  cfg = config.module.stylix;

  theme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
  cursorSize = 14;
  fontSize = 11;
in {
  options = {
    module.stylix.enable = mkEnableOption "Enables stylix";
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/barthofu/dotfiles/refs/heads/dev/dotfiles/.local/share/wallpapers/aesthetic/dune.jpg";
        sha256 = "RYN8KwJPDMfxrcosbpmjON0Y+I58IhB1Ke36LdohsxA=";
      };
      autoEnable = true;
      polarity = "dark";

      base16Scheme = theme;

      cursor = {
        name    = "Vimix-cursors";
        package = pkgs.vimix-cursors;
        size    = cursorSize;
      };

      fonts = {
        sizes = {
          applications = fontSize;
          terminal     = fontSize;
          popups       = fontSize;
          desktop      = fontSize;
        };

        serif = {
          package = pkgs.noto-fonts-cjk-serif;
          name    = "Noto Serif CJK JP";
        };

        sansSerif = {
          package = pkgs.noto-fonts-cjk-sans;
          name    = "Noto Sans CJK JP";
        };

        monospace = {
          package = pkgs.fira-code;
          name    = "Fira Code";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name    = "Noto Color Emoji";
        };
      };
    };
  };
}