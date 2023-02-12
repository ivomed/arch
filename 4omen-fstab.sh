#!/bin/bash

# ---------------------------------FSTAB------------------------------------------

sudo sed -i '$ a # \t\t /dev/nvme0n1p3 - nvme0' /etc/fstab
sudo sed -i '$ a #UUID=9da2759e-c996-4870-b8af-a4d1b01b2a07\t/media/btrfs/nvme0\tbtrfs\tdefaults,rw,relatime\t0\t0' /etc/fstab


sudo sed -i '$ a #nvme1' /etc/fstab

sudo sed -i '$ a # \t\t /dev/nvme1n1p1 - STORAGE' /etc/fstab
sudo sed -i '$ a UUID=361dce71-3f95-4a77-9aa4-a12a8b9a7dc8\t/media/btrfs/nvme1\tbtrfs\tdefaults,rw,relatime\t0\t0' /etc/fstab

sudo sed -i '$ a # \t\t /dev/nvme1n1p2 - NEXTCLOUD' /etc/fstab
sudo sed -i '$ a UUID=7b9bf9c0-f130-4cee-b0c6-c1ca9be46a95\t/media/btrfs/nc\tbtrfs\tdefaults,rw,relatime\t0\t0' /etc/fstab

sudo sed -i '$ a # \t\t /dev/nvme1n1p3 - BACKUPS' /etc/fstab
sudo sed -i '$ a UUID=6bbafff6-649d-4fbe-88b3-de4e747f17a9\t/media/btrfs/bkp\tbtrfs\tdefaults,rw,relatime\t0\t0' /etc/fstab


sudo sed -i '$ a #WINDOWS' /etc/fstab

sudo sed -i '$ a # \t\t /dev/sda4 - Windows SSD' /etc/fstab
sudo sed -i '$ a UUID=4A10DEA710DE9971\t/media/ntfs/w-ssd\tntfs-3g\tdefaults,rw,relatime,hide_hid_files\t0\t0' /etc/fstab


/media/btrfs/nc/Documents/Ivo/Linux/Arch\ Install/Scripts/Arch/Omen/* /home/ivo/arch/

# ---------------------------------REBOOT--------------------------------------
rm 4omen-fstab.sh
reboot

