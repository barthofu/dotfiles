{ pkgs, self, ... }:

{  
    imports = [
        ./hyprland
    ];

    home.packages = with pkgs; [
        # screenshot
        # grim
        # slurp

        # utils
        # self.packages.${pkgs.system}.wl-ocr
        # wl-clipboard
        # wl-screenrec
        # wlr-randr
    ];

    home.sessionVariables = {
        QT_QPA_PLATFORM = "wayland";
        SDL_VIDEODRIVER = "wayland";
        XDG_SESSION_TYPE = "wayland";
    };
}