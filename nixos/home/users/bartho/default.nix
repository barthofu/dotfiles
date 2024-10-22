{ isWorkstation
, isLinux
, hyprlandEnable ? false
, wmEnable ? false
, ...
}:

{
  nixpkgs.overlays = [  ];

  module = {
    gui = {
      hyprland.enable = hyprlandEnable && isWorkstation;
      hyprlock.enable = hyprlandEnable && isWorkstation;
      swaybg = {
        enable = hyprlandEnable && isWorkstation;
        wallpaper = "nature/snow_mountains.jpg";
      };
      wlogout.enable = hyprlandEnable && isWorkstation;
      wofi.enable = hyprlandEnable && isWorkstation;
    };

    dev = {
      git.enable = true;
      vscode.enable = isWorkstation;
    };

    terminal = {
      alacritty.enable = isWorkstation;
      atuin.enable = isWorkstation;
      navi.enable = isWorkstation;
      zoxide.enable = isWorkstation;
      zsh.enable = isWorkstation;
    };

    utils = {
      cliphist.enable = isWorkstation;
    };

    media = {
      obs-studio.enable = isWorkstation;
    };

    user = {
      packages.enable = true;
      xdg.enable = true;
    };
  };
}