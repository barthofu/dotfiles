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
        cm = "commit -m";
        cma = "! git add . && git commit -m";
        a = "commit --amend";
        a-all = "! git add . && git commit --amend --no-edit";
        f-push = "! git add . && git commit --amend --no-edit && git push --force-with-lease";
        ch = "checkout";
        s = "status -sb";
        unstage = "reset HEAD --";
        uncommit = "reset --soft HEAD^";
        discard = "reset --hard HEAD";
        # graph = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
        g = "! git graph";
        graph = "! git-graph";
        count-lines = "! git log --author=\"$1\" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf \"added lines: %s, removed lines: %s, total lines: %s\\n\", add, subs, loc }' #";
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

    home.packages = with pkgs; [
      lazygit
      git-graph
    ];
  };
}