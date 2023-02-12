#!/usr/bin/env bash

sudo pacman -Syu --noconfirm

#----------------------------------PARU-----------------------------------

git clone https://aur.archlinux.org/paru-bin
cd paru-bin
makepkg -si --noconfirm

# ---------------------------------APPS-----------------------------------

paru -S --noconfirm aic94xx-firmware wd719x-firmware zramd snap-pac-grub snapper-gui
paru -S --noconfirm it87-dkms-git  # samo na ST dekstop


#/media/btrfs/nc/Documents/Ivo/Linux/Arch\ Install/Scripts/Arch/Desktop/* /home/ivo/install/
#/media/btrfs/nc/Documents/Ivo/Linux/Arch\ Install/Scripts/Arch/Omen/* /home/ivo/install/

# ---------------------------------REBOOT--------------------------------------

sleep 1
rm 2paru.sh
sudo reboot
