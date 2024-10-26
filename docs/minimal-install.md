# NixOS Minimal Install - From Live ISO

The official NixOS.org site has very good documentation. This is a condensed version for myself.

https://nixos.org/manual/nixos/stable/#sec-booting-from-usb

You will need to `sudo` or `sudo -i` the majority of these commands.

## Create Installation Media

1. Flash the minimal image to a USB device from Linux
`dd if=<nixos-minimal-image.iso> of=/path/to/usb bs=4M conv=fsync`
2. Boot from the USB on the target device
3. Execute these commands:
   1. `sudo su` - to become root
   2. `loadkeys fr` - to set the keyboard layout
 
## Wireless Networking

You need to be connected to the internet to install NixOS. If you are using a wired connection, you can skip this step.

1. `rfkill unblock all`
2. `systemctl start wpa_supplicant`
3. Grab your wireless interface name by running `iwconfig`
4. `ifconfig <interface_id> up`
5. `wpa_passphrase "<ssid>" "<password>" | tee /etc/wpa_supplicant.conf`
6. Run `wpa_supplicant -B -c /etc/wpa_supplicant.conf -i <interface_id>`
7. If you don't directly have an IP adress, run `dhclient <interface_id>` to get one.

## Partition

1. `lsblk` - to identify connected drives
2. partition the disk
```bash
parted "/dev/sda" -- mklabel gpt
parted "/dev/sda" -- mkpart ESP fat32 1MB 512MB
parted "/dev/sda" -- mkpart primary 512MB 100%
parted "/dev/sda" -- set 1 esp on
```

## Create LUKS encrypted container

```bash
cryptsetup luksFormat /dev/sda2
cryptsetup luksOpen /dev/sda2 crypted
```

## Preparing LVM logical volumes

```bash
pvcreate /dev/mapper/crypted
vgcreate "vg" /dev/mapper/crypted
lvcreate -L 8G "vg" -n swap
lvcreate -l "100%FREE" "vg" -n root
```

## Formatting LVM volumes

```bash
mkfs.fat -F32 "/dev/sda1" -n boot 
mkfs.ext4 -L root "/dev/vg/root"
mkswap -L swap "/dev/vg/swap"
```

## Mounting file systems

```bash
mount "/dev/vg/root" /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon "/dev/vg/swap"
```

## Generate configuration

1. Generate > `nixos-generate-config --root /mnt`
2. Edit `configuration.nix` > `nano /mnt/etc/nixos/configuration.nix`

## Enable swap in hardware-configuration.nix

```
swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];
```

## Install and reboot

1. Install > `nixos-install`
2. You will be prompted for a root password afterwards.
3. Reboot > `reboot`