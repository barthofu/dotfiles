# NixOS EFI Boot Failure Postmortem

## Incident Summary

* **Date:** 2026-02-12
* **System:** NixOS (flake-based configuration) with dual-boot Windows on another disk
* **Symptoms:** On boot, the system displayed "Boot into firmware interface" and could not start NixOS.
* **Initial Observations:**
  * Connected live USB with nixos-minimal to access the system.
  * Attempted to mount root and boot partitions via `cryptsetup`, LVM, and labels.
  * Internet was unavailable initially, preventing flake rebuild.
  * `/boot` contained old recovery artifacts: `FSCK0000.REC`, `FOUND.000`.
* **Error During Rebuild:**

  * `systemd-boot not installed in ESP`
  * FAT filesystem errors: corrupted directory entries in `/boot/EFI/nixos/`

## Root Cause

* The **ESP (EFI System Partition) for NixOS** had become **corrupted** or **lost its FAT32 filesystem**, likely due to abrupt shutdowns or disk write errors.
* After formatting, the **partition label was missing**, causing mounting via label to fail.
* Systemd-boot could not install because the **ESP was empty or invalid**.
* Windows EFI partition was intact; the problem was isolated to the NixOS ESP.

## Steps Taken for Resolution

1. Installed nixos-minimal on a bootable USB, and then start it in "Installation (debug mode)"
2. Connected to ethernet
3. Mounted NixOS partitions via bootable live USB:
   ```bash
   cryptsetup luksOpen /dev/<crypted_data_partition> crypted
   lvchange -a y /dev/vg/swap
   lvchange -a y /dev/vg/root
   
   mount /dev/vg/root /mnt
   swapon /dev/vg/swap
   ```
4. Formated and mounted boot partition
   ```bash
   mkfs.fat -F32 /dev/<boot_partition>
   fatlabel /dev/<boot_partition> boot

   mkdir -p /mnt/boot
   mount /dev/disk/by-label/boot /mnt/boot
   ```
5. Reinstalled systemd-boot on the ESP before rebuild:
   ```bash
   nixos-enter
   bootctl --esp-path=/boot install
   ```
6. Verified installation of systemd-boot:
   ```bash
   ls /boot/EFI/systemd
   ls /boot/loader
   ```
7. Rebuilt NixOS flake configuration:
   ```bash
   nixos-rebuild boot --flake /home/bartho/.dotfiles/nixos#lenovo
   ```
8. **Checked EFI entries**:
   ```bash
   bootctl list
   ```
   Confirmed NixOS generations and Windows boot entries.
9.  **Rebooted system** successfully; systemd-boot menu appeared and NixOS booted.

## Key Lessons Learned

* **ESP corruption can silently prevent boot** even if root and LVM volumes are intact.
* **Systemd-boot must be installed on a valid FAT32 ESP** before NixOS can rebuild boot entries.
* **Mounting by label may fail** after formatting; mounting by device path is safer.
* **Recovery artifacts (`FSCK0000.REC`, `FOUND.000`) indicate prior corruption** but can be ignored once ESP is reformatted.
* Always verify the **correct ESP** in dual-boot setups to avoid affecting Windows.

## Resolution Summary

The incident was resolved by:

1. Reformatting the NixOS ESP (if necessary) to ensure a valid FAT32 filesystem.
2. Installing systemd-boot on the ESP using `bootctl --esp-path=/boot install`.
3. Rebuilding the NixOS flake configuration.

After these steps, the system booted normally, dual-boot Windows remained intact, and all NixOS generations were accessible via systemd-boot.
