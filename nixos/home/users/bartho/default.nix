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

    user = {
      packages.enable = true;
      xdg.enable = true;
    };
  };
}