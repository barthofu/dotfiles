#!/bin/sh

# Usage: ./add_package.sh <nixpkg> <target> [type] [user]
# Example: ./add_package.sh teamviewer home workstation

# Arguments
nixpkg=$1
target=$2
type=${3:-gui} # Default to workstation
user=${4:-$USER} # Default to current user

# Files
system_file="$HOME/.dotfiles/nixos/system/modules/packages/default.nix"
home_file="$HOME/.dotfiles/nixos/home/users/$user/modules/packages/default.nix"

# Determine target file and validate inputs
case "$target" in
  system)
    file="$system_file"
    ;;
  home)
    file="$home_file"
    ;;
  *)
    echo "Invalid target: choose 'home' or 'system'"
    exit 1
    ;;
esac

# Determine the section comment based on type
case "$type" in
  cli)
    section_comment="# To sort cli"
    ;;
  gui)
    section_comment="# To sort gui"
    ;;
  *)
    echo "Invalid type: choose 'cli' or 'gui'"
    exit 1
    ;;
esac

# Insert package under the appropriate section
sed -i "/$section_comment/ {
  /# To sort/ a\      $nixpkg
}" "$file"

# Change directory to dotfiles
cd "$HOME/.dotfiles"

# Commit changes
git add "$file" 

# Rebuild system and if it errors then revert changes
just rebuild
if [ $? -ne 0 ]; then
  git checkout -- "$file"
  echo ""
  echo "======================"
  echo "Rebuild failed, reverting changes"
else
  git commit -m "feat($target/package): $nixpkg"
	git push
	echo ""
	echo "======================"
	echo "Package added successfully"
fi
