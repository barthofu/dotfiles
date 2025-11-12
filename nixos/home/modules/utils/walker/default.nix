{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.utils.walker;
	wofiEnabled = config.module.gui.wofi.enable;
in {
  options.module.utils.walker = {
    enable = mkEnableOption "Enables walker";
  };

  config = mkIf cfg.enable {
      
    programs.walker = {
      enable = true;
      runAsService = true;

      config = {
        theme = "default";
        force_keyboard_focus = false;
        close_when_open = true;
        selection_wrap = false;
        global_argument_delimiter = "#";
        keep_open_modifier = "shift";
        exact_search_prefix = "'";
        disable_mouse = false;

        shell = {
          anchor_top = true;
          anchor_bottom = true;
          anchor_left = true;
          anchor_right = true;
        };

        placeholders."default" = {
          input = "Search";
          list = "No Results";
        };

        keybinds = {
          close = "Escape";
          next = "Down";
          previous = "Up";
          toggle_exact = "ctrl e";
          resume_last_query = "ctrl r";
          quick_activate = [ "F1" "F2" "F3" "F4" ];
        };

        providers = {
          default = [
            "desktopapplications"
            "calc"
            "runner"
            "menus"
            "websearch"
          ];
          empty = [ "desktopapplications" ];

          prefixes = [
            { prefix = ";"; provider = "providerlist"; }
            { prefix = "/"; provider = "files"; }
            { prefix = "."; provider = "symbols"; }
            { prefix = "!"; provider = "todo"; }
            { prefix = "="; provider = "calc"; }
            { prefix = "@"; provider = "websearch"; }
            { prefix = ":"; provider = "clipboard"; }
          ];

          archlinuxpkgs = {
            default = "install";
            install = "Return";
            remove = "ctrl d";
          };

          calc = {
            default = "copy";
            copy = "Return";
            save = "ctrl s";
            delete = "ctrl d";
          };

          websearch = {
            default = "search";
            search = "Return";
            remove_history = "ctrl BackSpace";
          };

          providerlist = {
            default = "activate";
            activate = "Return";
          };

          clipboard = {
            time_format = "%d.%m. - %H:%M";
            default = "copy";
            copy = "Return";
            delete = "ctrl d";
            edit = "ctrl o";
            toggle_images_only = "ctrl i";
          };

          desktopapplications = {
            default = "start";
            start = "Return";
            start_keep_open = "shift Return";
            remove_history = "ctrl BackSpace";
            toggle_pin = "ctrl p";
          };

          files = {
            default = "open";
            open = "Return";
            open_dir = "ctrl Return";
            copy_path = "ctrl shift c";
            copy_file = "ctrl c";
          };

          todo = {
            default = "save";
            save = "Return";
            delete = "ctrl d";
            mark_active = "ctrl a";
            mark_done = "ctrl f";
            clear = "ctrl x";
          };

          runner = {
            default = "start";
            start = "Return";
            start_terminal = "shift Return";
            remove_history = "ctrl BackSpace";
          };

          dmenu = {
            default = "select";
            select = "Return";
          };

          symbols = {
            default = "copy";
            copy = "Return";
            remove_history = "ctrl BackSpace";
          };

          unicode = {
            default = "copy";
            copy = "Return";
            remove_history = "ctrl BackSpace";
          };

          menus = {
            default = "activate";
            activate = "Return";
            remove_history = "ctrl BackSpace";
          };
        };
      };

      # If this is not set the default styling is used.
      themes."default" = {
        style = ''
          /* import */
          @import url('./true-style.css');
        '';
      };
    };
  };
}