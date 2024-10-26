# Utilities

## Commands

- `lsblk -o name,uuid | grep nvme0n1p3 | awk '{print $NF}'` to get the UUID of the partition
