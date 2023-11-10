{ ... }:

{
    programs.zsh = {
        enable = true;

        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;

        oh-my-zsh = {
            enable = true;
            plugins = [ 
                "git" 
            ];
            theme = "robbyrussell"; # TODO: to change/customize
        };
    };
}