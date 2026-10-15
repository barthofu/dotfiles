{ lib
, config
, inputs
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.programs.hyprland;
  hyprlandPkg = import ../../../../lib/hyprland.nix { inherit inputs pkgs; };
in {
  options.module.programs.hyprland = {
    enable = mkEnableOption "Enables hyprland";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = hyprlandPkg;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
}
