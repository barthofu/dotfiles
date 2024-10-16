{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.dev.git;
in {
  options.module.dev.git = {
    enable = mkEnableOption "Enables git";
  };

  config = mkIf cfg.enable {
    programs.gh.gitCredentialHelper.enable = false;
    programs.git = {
        enable = true;
        package = pkgs.gitFull;
        
        userName = "Bartholomé Gili";
        userEmail = "dev.bartho@gmail.com";

        aliases = {
            graph = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
            amend-all = "add . && git commit --amend --no-edit";
            count-lines = "! git log --author=\"$1\" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf \"added lines: %s, removed lines: %s, total lines: %s\\n\", add, subs, loc }' #";
            co = "commit -m \"$1\"";
            ch = "checkout";
            st = "status";
        };

        extraConfig = {
            init.defaultBranch = "main";
            github.user = "barthofu";
            credential = {
                "https://github.com" = {
                    helper = "!gh auth git-credential";
                };
                "https://gist.github.com" = {
                    helper = "!gh auth git-credential";
                };
            };
        };
    };
  };
}