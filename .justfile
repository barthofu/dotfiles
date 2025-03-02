# nix
rebuild:
    sudo nixos-rebuild switch --flake ./nixos#lenovo
install:
    sudo nixos-install --flake ./nixos#lenovo
lint:
    nix run 'nixpkgs/nixos-unstable#statix' -- check ./nixos
deadnix:
    nix run 'nixpkgs/nixos-unstable#deadnix' -- check ./nixos
update:
    nix flake update --flake ./nixos
update-master:
    cd nixos && nix flake lock --update-input master
clean:
    nix-collect-garbage -d
    sudo nix-collect-garbage -d

# git
f-pull:
    git reset --hard HEAD~1 && git pull
f-push:
    git add . && git commit --amend --no-edit && git push --force-with-lease

# dotbot
link:
    sudo chmod +x ./dotfiles/.local/scripts/* && ./install
