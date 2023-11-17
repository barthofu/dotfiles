{ config, pkgs, ... }:

{
    imports = [
        ./programs
        ./packages.nix
    ];

    home = {
        username = "bartho";
        homeDirectory = "/home/bartho";
        stateVersion = "23.05";
    };

    # TODO: move and/or check if it works
    xsession.windowManager.i3 = {
      config = {
        startup = [
          {
            command =
              "${pkgs.feh}/bin/feh --bg-fill ~/.dotfiles/configs/nixos/assets/wallpapers/umbrella_girl.jpg";
            always = true;
            notification = false;
          }
        ];
      };
    };

    programs.home-manager.enable = true;
}