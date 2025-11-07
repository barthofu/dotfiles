#!/usr/bin/env bash

cryptsetup luksOpen /dev/nvme0n1p5 crypted
lvchange -a y /dev/vg/swap
lvchange -a y /dev/vg/root

mount /dev/vg/root /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/vg/swap