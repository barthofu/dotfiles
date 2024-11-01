{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.boot;
in {
  options.module.boot = {
    enable = mkEnableOption "Enables boot";
  };

  config = mkIf cfg.enable {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;

        # Hide the OS choice for bootloaders.
        # It's still possible to open the bootloader list by pressing any key
        # It will just not appear on screen unless a key is pressed
        timeout = 0;
      };

      # Enable "Silent Boot"
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];

      # Enable Plymouth
      plymouth = {
        enable = true;
        font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
        # theme = "dna";
        # themePackages = with pkgs; [
        #   (adi1090x-plymouth-themes.override {
        #     selected_themes = [ 
        #       "dna"
        #       "colorful"
        #       "colorful_sliced"
        #       "cuts_alt"
        #       "deus_ex"
        #       "metal_ball"
        #       "red_loader"
        #       "sliced"
        #       "sphere"
        #     ];
        #   })
        # ];
      };
    };
  };
}