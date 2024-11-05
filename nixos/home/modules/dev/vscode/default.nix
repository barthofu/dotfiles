{ config
, pkgs-master
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
      package = if cfg.useCodium then pkgs-master.codium else pkgs-master.vscode;

      extensions = (with pkgs-master.vscode-extensions; [
        ms-vscode-remote.remote-ssh
      ]);
    };
  };
}