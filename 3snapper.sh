#!/bin/bash

#----------------------------------SNAPPER-----------------------------------

umount /.snapshots
rm -r /.snapshots
snapper -c root create-config /
btrfs subvolume delete /.snapshots
mkdir /.snapshots
mount -a
btrfs subvolume set-default 256 /
chown -R :wheel /.snapshots/

sed -i '/ALLOW_GROUPS=""/c \ALLOW_GROUPS="wheel"' /etc/snapper/configs/root
sed -i '/TIMELINE_LIMIT_HOURLY="10"/c \TIMELINE_LIMIT_HOURLY="5"' /etc/snapper/configs/root
sed -i '/TIMELINE_LIMIT_DAILY="10"/c \TIMELINE_LIMIT_DAILY="7"' /etc/snapper/configs/root
sed -i '/TIMELINE_LIMIT_MONTHLY="10"/c \TIMELINE_LIMIT_MONTHLY="0"' /etc/snapper/configs/root
sed -i '/TIMELINE_LIMIT_YEARLY="10"/c \TIMELINE_LIMIT_YEARLY="0"' /etc/snapper/configs/root

#----------------------------------RAZNO-----------------------------------

echo "Numlock=On" >> /etc/sddm.conf
sed -i '12s/.//' /etc/profile.d/freetype2.sh
echo "PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"" >> /etc/environment
echo "EDITOR="/usr/bin/vim"" >> /etc/environment
sed -i '/#DefaultTimeoutStopSec=90s/c \DefaultTimeoutStopSec=10s' /etc/systemd/system.conf
mkdir /mnt/nas
chown ivo:ivo /mnt/nas
chsh -s /bin/fish

#----------------------------------SERVICES-------------------------------

sudo systemctl mask hibernate.target hybrid-sleep.target
sudo systemctl enable zramd.service
systemctl enable snapper-timeline.timer
systemctl enable snapper-cleanup.timer
sudo systemctl enable fstrim.timer

# ---------------------------------REBOOT--------------------------------------
rm 3snapper.sh
reboot

