rebuild:
    sudo nixos-rebuild switch --flake ./nixos#lenovo
install:
    sudo nixos-install --flake ./nixos#lenovo
f-pull:
    git reset --hard HEAD~1 && git pull
f-push:
    git add . && git commit --amend --no-edit && git push --force-with-lease
link:
    ./install