{ config
, pkgs
, lib
, ...
}:

with lib;

let
  cfg = config.module.dev.vscode;
in {
  options.module.dev.vscode = {
    enable = mkEnableOption "Enables vscode";
    useCodium = mkOption {
      type = types.bool;
      default = false;
      description = "Use codium instead of vscode";
    };
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = if cfg.useCodium then pkgs.codium else pkgs.vscode;

      extensions = (with pkgs.vscode-extensions; [
        ms-vscode-remote.remote-ssh
      ]);
    };
  };
}