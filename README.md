<div align="center"><img src="assets/nixos-logo.png" width="300px"></div>
<h1 align="center">Bartho's Nix / NixOS config ❄️</h1>

<div align="center">

![nixos](https://img.shields.io/badge/NixOS-unstable-blue.svg?style=flat&logo=nixos&logoColor=CAD3F5&colorA=24273A&colorB=8aadf4)
![flake check](https://img.shields.io/static/v1?label=Nix%20Flake&message=Check&style=flat&logo=nixos&colorA=24273A&colorB=9173ff&logoColor=CAD3F5)
![license](https://img.shields.io/static/v1.svg?style=flat&label=License&message=Unlicense&colorA=24273A&colorB=91d7e3&logo=unlicense&logoColor=91d7e3&)

</div>

This repository holds my NixOS configuration. It is fully reproducible, flakes based and uses home-manager for user configurations. Feel free to utilize it in its entirety or borrow specific components for your own configuration!

> [!WARNING]
> This readme is very likely out-dated at at any given time. This is for two
> reasons. The first is that Nix, as a language, suffers from an apparent need
> to be frequently refractored. The second reason is that this is my personal
> configuration, and it is under constant revision.
>
> As with all Nix code (and with software in general), the ultimate form of
> documentation is the source code itself.

### Table of contents

- [Features](#features)
- [File structure](#file-structure)
- [Preview](#preview)
- [Inspirations](#inspirations)

You can also find the full documentation in the [docs folder](docs/).

## Features

- ❄️ **Flakes** for precise dependency management of the entire system.
- 🏡 **Home Manager** to configure all used software for the user.
- 📁 Config file structure and modules with options.

## File structure

```bash
.
├── nixos
│   ├── hosts.nix # hosts configuration
│   ├── flake.nix # configuration entry point
│   ├── home # entry point for creating a home manager user
│   │   ├── modules # home-manager modules organized in categories
│   │   ├── bin # binaries from scripts
│   │   └── users # specific users configurations for home manager 
|   |       └── modules # specific user modules
│   ├── systems # system configuration
│   │   ├── modules # system modules organized in categories
│   │   └── machines # machines specific configurations
│   |       └── modules # machine specific modules
│   ├── lib # helper functions and variables
│   ├── pkgs # self sealed packages
│   ├── modules # nix common modules for all users and machines
│   └── overlays # common overlays
├── dotfiles # dotfiles for various programs symlinked to home folder using dotbot
├── scripts # various scripts
└── assets # assets used in the readme
```

## Preview

*The showcased images do not reflect the latest version of the system's appearance. The final setup may vary slightly.*

## Inspirations

Some of the inspirations for this configuration are:
- https://github.com/TheMaxMur/NixOS-Configuration
- 