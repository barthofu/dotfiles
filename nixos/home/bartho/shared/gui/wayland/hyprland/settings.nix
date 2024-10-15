{ config, ... }: let
    variant = "dark";
in {
    wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";
        # env = [
        #     "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        # ];

        input = {
            kb_layout = "fr";

            # focus change on cursor move
            follow_mouse = 1;
            accel_profile = "flat";
            touchpad.scroll_factor = 0.1;
        };

        # dwindle = {
        #     # keep floating dimentions while tiling
        #     pseudotile = true;
        #     preserve_split = true;
        # };
        
    };
}