rebuild:
    sudo nixos-rebuild switch --flake ./configs/nixos#lenovo
install:
    sudo nixos-install --flake ./configs/nixos#lenovo
f-pull:
    git reset --hard HEAD~1 && git pull
f-push:
    git add . && git commit --amend --no-edit && git push --force-with-lease
