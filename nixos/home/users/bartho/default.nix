{ isWorkstation
, isLinux
, hyprlandEnable ? false
, wmEnable ? false
, ...
}:

{
  nixpkgs.overlays = [];

  # services.pulseeffects = {
  #   enable = false;
  # };

  stylix.targets = {
    vscode.enable = false;
    wofi.enable = false;
    waybar.enable = false;
    feh.enable = false;
    sway.enable = false;
    wpaperd.enable = false;
  };

  module = {
    gui = {
      hyprland.enable = hyprlandEnable && isWorkstation;
      hyprlock.enable = hyprlandEnable && isWorkstation;
      hypridle.enable = hyprlandEnable && isWorkstation;
      swaybg.enable = hyprlandEnable && isWorkstation;
      swaync.enable = hyprlandEnable && isWorkstation;
      wlogout.enable = hyprlandEnable && isWorkstation;
      wofi.enable = hyprlandEnable && isWorkstation;
      gtk.enable = isWorkstation;
    };

    dev = {
      git.enable = true;
      vim.enable = true;
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
      syncthing.enable = true;
      cliphist.enable = isWorkstation;
      winapps.enable = isWorkstation;
    };

    media = {
      obs-studio.enable = isWorkstation;
    };

    web = {
      firefox.enable = isWorkstation;
    };

    bin = {
      nix-add.enable = true;
      meteo.enable = isWorkstation;
      soundcloud.enable = isWorkstation;
      ping-monitor.enable = isWorkstation;
      yuzu.enable = isWorkstation;
    };

    user = {
      packages.enable = true;
      xdg.enable = true;
    };
  };
}
