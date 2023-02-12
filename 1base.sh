#!/bin/bash

#----------------------------------VRIJEME--------------------------------

ln -sf /usr/share/zoneinfo/Europe/Zagreb /etc/localtime
hwclock --systohc
timedatectl set-ntp true

#----------------------------------LOCALE---------------------------------

sed -i '/#en_US.UTF-8 UTF-8/c \en_US.UTF-8 UTF-8' /etc/locale.gen
sed -i '/#hr_HR.UTF-8 UTF-8/c \hr_HR.UTF-8 UTF-8' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=croat" >> /etc/vconsole.conf

#----------------------------------NAME-----------------------------------

echo "IME" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 IME.localdomain IME" >> /etc/hosts
echo root:PASSWD | chpasswd

#----------------------------------APPS+KDE-------------------------------

pacman -Sy --noconfirm --needed
pacman -S --noconfirm base-devel linux-zen-headers linux-firmware grub efibootmgr dosfstools os-prober mtools networkmanager dialog wpa_supplicant wireless_tools nano wget reflector snapper btrfs-progs grub-btrfs duf rsync unzip ntfs-3g bash-completion sof-firmware flatpak ttf-droid ttf-hack ttf-font-awesome otf-font-awesome ttf-lato ttf-liberation ttf-linux-libertine ttf-opensans ttf-roboto ttf-ubuntu-font-family terminus-font ufw cronie htop sshfs samba openssh nfs-utils cups nmap print-manager cups-pdf grub-customizer neofetch fish

#----------------------------------BTRFS----------------------------------

sed -i '/MODULES=()/c \MODULES=(btrfs)' /etc/mkinitcpio.conf
mkinitcpio -p linux-zen

#----------------------------------GRUB-----------------------------------

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB



#----------------------------------DESKTOP--------------------------------
#sed -i '/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"/c \GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 amd_iommu=on"' /etc/default/grub
#----------------------------------OMEN-----------------------------------
#sed -i '/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"/c \GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 intel_iommu=on"' /etc/default/grub



sleep 1
sed -i '63s/.//' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

#----------------------------------USER-----------------------------------

useradd -mG wheel,users,storage,power,lp,adm,optical,audio,video ivo
echo ivo:PASSWD | chpasswd
echo "ivo ALL=(ALL) ALL" >> /etc/sudoers.d/ivo

#----------------------------------SUDO-----------------------------------

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

#----------------------------------MULTILIB-------------------------------

sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
pacman-key --lsign-key FBA220DFC880C036
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

echo "[chaotic-aur]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

#----------------------------------SERVICES-------------------------------

systemctl enable NetworkManager
systemctl enable cups.service
systemctl enable cronie
systemctl enable sshd
systemctl enable smb
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl mask hibernate.target hybrid-sleep.target

#----------------------------------CHMOD---------------------------------

chmod +x 2paru.sh
chmod +x 3snapper.sh
chmod +x 4omen-fstab.sh
chmod +x 4st-fstab.sh
mv /arch /home/ivo
chmod ivo:ivo /home/ivo/arch

#----------------------------------EXIT----------------------------------

printf "\e[1;32mDONE! Exit, umount -a and REBOOT \e[0m"
rm 1base.sh
