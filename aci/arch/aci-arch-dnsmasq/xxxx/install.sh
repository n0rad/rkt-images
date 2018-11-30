#!/bin/bash

# configuration

INSTALL_DRIVE=/dev/vda
PARTITION_BOOT=1
PARTITION_ROOT=2
LABEL_ROOT=ROOT
MOUNT_PATH=/mnt
HTTP_SERVER=http://eurobuild3.lan:8080
HOSTNAME=archlinux
NTP_SERVER=192.168.1.1

echo "Partitioning and creating filesystem.."

wipefs -a ${INSTALL_DRIVE}
printf ",128M,L,*\n" | /sbin/sfdisk -f ${INSTALL_DRIVE}
printf ",,L,*\n" | /sbin/sfdisk -a -f ${INSTALL_DRIVE}

mkfs.ext2 ${INSTALL_DRIVE}${PARTITION_BOOT}
mkfs.ext4 ${INSTALL_DRIVE}${PARTITION_ROOT}

mount ${INSTALL_DRIVE}${PARTITION_ROOT} ${MOUNT_PATH}
mkdir ${MOUNT_PATH}/boot
mount ${INSTALL_DRIVE}${PARTITION_BOOT} ${MOUNT_PATH}/boot

echo "Installing minimalistic base system.."

sed -i 's/^SigLevel.*/SigLevel = Never/g' /etc/pacman.conf

sed -i "/\[core\]/aServer = ${HTTP_SERVER}/\$repo/os/\$arch" /etc/pacman.conf
sed -i "/\[extra\]/aServer = ${HTTP_SERVER}/\$repo/os/\$arch" /etc/pacman.conf
sed -i "/\[community\]/aServer = ${HTTP_SERVER}/\$repo/os/\$arch" /etc/pacman.conf

pacstrap ${MOUNT_PATH} filesystem grep findutils coreutils glibc bash pacman mkinitcpio linux dhcpcd systemd sed systemd-sysvcompat

sed -i 's/^SigLevel.*/SigLevel = Never/g' ${MOUNT_PATH}/etc/pacman.conf

sed -i "/\[core\]/aServer = ${HTTP_SERVER}/\$repo/os/\$arch" ${MOUNT_PATH}/etc/pacman.conf
sed -i "/\[extra\]/aServer = ${HTTP_SERVER}/\$repo/os/\$arch" ${MOUNT_PATH}/etc/pacman.conf
sed -i "/\[community\]/aServer = ${HTTP_SERVER}/\$repo/os/\$arch" ${MOUNT_PATH}/etc/pacman.conf
printf "\n[myrepo]\nServer = ${HTTP_SERVER}/\$repo/os/\$arch\n" >> ${MOUNT_PATH}/etc/pacman.conf

arch-chroot ${MOUNT_PATH} pacman -Sy

echo "Installing boot loader.."

genfstab -p ${MOUNT_PATH} > ${MOUNT_PATH}/etc/fstab

arch-chroot ${MOUNT_PATH} pacman --noconfirm -S grub
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/g' ${MOUNT_PATH}/etc/default/grub
arch-chroot ${MOUNT_PATH} grub-mkconfig -o /boot/grub/grub.cfg
arch-chroot ${MOUNT_PATH} grub-install --force /dev/vda

#echo "Configuring base system.."

#sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' ${MOUNT_PATH}/etc/locale.gen
#arch-chroot ${MOUNT_PATH} locale-gen
#echo LANG=en_US.UTF-8 > ${MOUNT_PATH}/etc/locale.conf
#
#ln -s /usr/share/zoneinfo/Europe/Zurich ${MOUNT_PATH}/etc/localtime
arch-chroot ${MOUNT_PATH} hwclock --systohc --utc

echo ${HOSTNAME} > ${MOUNT_PATH}/etc/hostname

arch-chroot ${MOUNT_PATH} systemctl enable dhcpcd@ens3.service

arch-chroot ${MOUNT_PATH} sh -c "echo 'root:xx' | chpasswd"

arch-chroot ${MOUNT_PATH} pacman --noconfirm -S ntp

arch-chroot ${MOUNT_PATH} ntpdate ${NTP_SERVER}

sed -i 's/^server/#server/g' ${MOUNT_PATH}/etc/ntp.conf
echo "server ${NTP_SERVER}" >> ${MOUNT_PATH}/etc/ntp.conf

arch-chroot ${MOUNT_PATH} systemctl enable ntpd.service

arch-chroot ${MOUNT_PATH} pacman --noconfirm -S libyaml cfengine

echo "Unmounting.."

umount ${MOUNT_PATH}/boot
umount ${MOUNT_PATH}

echo "Powering off.."

sleep 10
systemctl poweroff
