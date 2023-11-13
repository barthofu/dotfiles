{ pkgs, ... }:

{
    programs.git = {
        enable = true;
        
        userName = "Bartholomé Gili";
        userEmail = "dev.bartho@gmail.com";
        package = pkgs.gitFull;

        extraConfig = {
            init.defaultBranch = "main";
            github.user = "barthofu";
        };
    };
}