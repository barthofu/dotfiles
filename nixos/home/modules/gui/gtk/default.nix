{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.gui.gtk;
in {
  options.module.gui.gtk = {
    enable = mkEnableOption "Enables gtk";
  };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Graphite-Dark";
        package = pkgs.graphite-gtk-theme.override {
          tweaks = ["darker"];
          themeVariants = ["pink"];
          colorVariants = ["dark"];
        };
      };
      # font = {
      #   package = (pkgs.nerdfonts.override { fonts = [ "Mononoki" ]; });
      #   name = "Mononoki Nerd Font Regular";
      #   size = 18;
      # };
      # iconTheme = {
      #   package = (pkgs.catppuccin-papirus-folders.override { flavor = "mocha"; accent = "peach"; });
      #   name  = "Papirus-Dark";
      # };
      # theme = {
      #   package = (pkgs.catppuccin-gtk.override { accents = [ "peach" ]; size = "standard"; variant = "mocha"; });
      #   name = "Catppuccin-Mocha-Standard-Peach-Dark";
      # };
    };
  };
}
