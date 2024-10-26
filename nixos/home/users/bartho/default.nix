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
        wallpaper = "aesthetic/dune.jpg";
      };
      wlogout.enable = hyprlandEnable && isWorkstation;
      wofi.enable = hyprlandEnable && isWorkstation;
    };

    dev = {
      git.enable = true;
      vscode.enable = isWorkstation;
    };

    terminal = {
      zsh.enable = true;
      navi.enable = true;
      zoxide.enable = true;
      cava.enable = true;
      atuin.enable = true;
      yazi.enable = true;
      alacritty.enable = isWorkstation;
      kitty.enable = isWorkstation;
    };

    utils = {
      cliphist.enable = isWorkstation;
    };

    media = {
      obs-studio.enable = isWorkstation;
    };

    web = {
      firefox.enable = isWorkstation;
    };

    bin = {
      meteo.enable = isWorkstation;
    };

    user = {
      packages.enable = true;
      xdg.enable = true;
    };
  };
}
