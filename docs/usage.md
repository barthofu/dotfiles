# How to use this repo
## Requirements: NixOS, x86_64

These steps assume that you have already installed NixOS.

For documentation on how to complete a minimal NixOS install: [Minimal Install](minimal-install.md).

There are no inherent advantages to using the minimal installation as opposed to the GUI. If you want to enable LUKS without manually encrypting your drive, use the GUI.

## Requirements

- NixOS
- x86_64

## Installation

1. Clone the repository
```bash
git clone https://github.com/barthofu/dotfiles
```
2. Install dotfiles
```bash
./install
```
3. Build the system 
```bash
sudo nixos-rebuild switch --flake '.#hostname'
```
4. Reboot

## Usage

When modifying the configuration, you can rebuild the system with the following command:
```bash
just rebuild
```