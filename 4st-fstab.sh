#!/bin/bash

# ---------------------------------FSTAB------------------------------------------

sudo sed -i '$ a # \t\t /dev/sda3' /etc/fstab
sudo sed -i '$ a UUID=daca0b02-b1a3-49ee-91ed-a084a71af4aa\t/media/btrfs/sda3\tbtrfs\tdefaults,rw,relatime\t0\t0' /etc/fstab


sudo sed -i '$ a #nvme1' /etc/fstab

sudo sed -i '$ a # \t\t /dev/nvme1n1p1 - STORAGE' /etc/fstab
sudo sed -i '$ a UUID=361dce71-3f95-4a77-9aa4-a12a8b9a7dc8\t/media/btrfs/nvme1\tbtrfs\tdefaults,rw,relatime\t0\t0' /etc/fstab

sudo sed -i '$ a # \t\t /dev/nvme1n1p2 - NEXTCLOUD' /etc/fstab
sudo sed -i '$ a UUID=7b9bf9c0-f130-4cee-b0c6-c1ca9be46a95\t/media/btrfs/nc\tbtrfs\tdefaults,rw,relatime\t0\t0' /etc/fstab

sudo sed -i '$ a # \t\t /dev/nvme1n1p3 - BACKUPS' /etc/fstab
sudo sed -i '$ a UUID=6bbafff6-649d-4fbe-88b3-de4e747f17a9\t/media/btrfs/bkp\tbtrfs\tdefaults,rw,relatime\t0\t0' /etc/fstab

sudo sed -i '$ a #WINDOWS' /etc/fstab

sudo sed -i '$ a # \t\t /dev/nvme0n1p4 - Windows SSD' /etc/fstab
sudo sed -i '$ a UUID=A46CC7B66CC78212\t/media/ntfs/w-ssd\tntfs-3g\tdefaults,rw,relatime,hide_hid_files\t0\t0' /etc/fstab


/media/btrfs/nc/Documents/Ivo/Linux/Arch\ Install/Scripts/Arch/Desktop/* /home/ivo/arch/

# ---------------------------------REBOOT--------------------------------------
rm 4st-fstab.sh
reboot

