rebuild:
    sudo nixos-rebuild switch --flake /etc/nixos#lenovo
install:
    sudo nixos-install --flake /etc/nixos#lenovo
force-pull:
    git reset --hard HEAD~1 && git pull
force-push:
    git add . && git commit --amend --no-edit && git push --force-with-lease
