{ config
, pkgs
, lib
, ...
}:

with lib;

let
  cfg = config.module.bin.nix-add;
in {
  options.module.bin.nix-add = {
    enable = mkEnableOption "Enables nix-add";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
        (writeShellScriptBin "nix-add" (builtins.readFile ./nix-add.sh))
    ];
  };
}