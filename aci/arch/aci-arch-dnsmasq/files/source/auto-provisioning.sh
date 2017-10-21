#!/bin/bash
set -e
set -x

die() {
    echo -e "\e[0;31m${@}\e[0m"
	exit 1
}

echo_purple() {
    echo -e "\e[0;35m${@}\e[0m"
}

echo_green() {
    echo -e "\e[0;32m${@}\e[0m"
}

echo_yellow() {
    echo -e "\e[0;93m${@}\e[0m"
}


disk=/dev/sda
hostname=srv1
ip=192.168.42.65
gateway=192.168.42.8
newuser=admin
mirror="http://archlinux.mirrors.ovh.net/archlinux/\$repo/os/\$arch"
pingcheckhost="google.fr"
#mymac=$(ip addr show dev ens3 | sed -rn 's#^\s+link/ether ([0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}:[0-9a-f]{2}).*$#\1#p')


echo_purple "Preparing install system ..."
loadkeys fr
if [ -z ${mirror} ]; then
    cat <<EOF >/etc/pacman.d/mirrorlist
Server = ${mirror}
EOF
fi




if [ ! $(ls ${disk}?) ]; then
    echo_purple "Disk is not ready ..."

    parted -s ${disk} mklabel msdos
    parted -s ${disk} mkpart primary ext3 1MiB 100MiB   # /boot
    parted -s ${disk} mkpart primary ext4 100MiB 10Gb   # /new_root1
    parted -s ${disk} mkpart primary ext4 10Gb 20Gb     # /new_root2
    parted -s ${disk} mkpart primary ext4 20Gb 100%     # /data
    parted -s ${disk} set 1 boot on

    mkfs.ext4 -F ${disk}4
fi

echo_purple "Mounting ..."

mkfs.ext3 -F ${disk}1 # TODO
mkfs.ext4 -F ${disk}2

mount ${disk}2 /mnt
mkdir /mnt/boot
mount ${disk}1 /mnt/boot
mkdir /mnt/data
mount ${disk}4 /mnt/data

#mkdir -p /mnt/data/var/cache /mnt/var
#cd /mnt/var && ln -s ../data/var/cache cache

echo_purple "Waiting for internet connection  ..."
while ! ping -c1 -W0.3 "$pingcheckhost" >/dev/null; do
	sleep 1
done


echo_purple "Pacstrapping  ..."
pacstrap /mnt base base-devel syslinux ntp sudo openssh haveged htop git zsh \
    screen dnsutils vim net-tools wget vim

echo_purple "Configuring  ..."
genfstab -p /mnt >> /mnt/etc/fstab
echo ${hostname} > /mnt/etc/hostname

cat << EOF >/mnt/etc/systemd/network/10-static-ethernet.network
[Match]
Name=e*

[Network]
Address=${ip}/24
Gateway=${gateway}
EOF

ln -sf /usr/share/zoneinfo/Europe/Paris /mnt/etc/localtime
echo "en_US.UTF-8 UTF-8" > /mnt/etc/locale.gen
arch-chroot /mnt locale-gen

echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf
cat <<EOF > /mnt/etc/vconsole.conf
KEYMAP=fr
FONT=
EOF

# todo this should be run only once since only one boot
cat <<EOF >/mnt/boot/syslinux/syslinux.cfg
serial 0 115200
DEFAULT arch
PROMPT 0
TIMEOUT 30
UI menu.c32

LABEL arch
	MENU LABEL Arch Linux
	LINUX ../vmlinuz-linux
	APPEND root=${disk}2 rw logo.nologo elevator=deadline nomodeset
	INITRD ../initramfs-linux.img
EOF

#cat <<EOF >/mnt/etc/ssh/sshd_config
#Port 22
#Protocol 2
#PermitRootLogin yes
#PubkeyAuthentication yes
#AuthorizedKeysFile      .ssh/authorized_keys
#PasswordAuthentication no
#ChallengeResponseAuthentication no
#UsePAM yes
#GatewayPorts clientspecified
#PrintMotd no # pam does that
#UsePrivilegeSeparation sandbox          # Default for new installations.
#Ciphers aes256-ctr,aes192-ctr,aes128-ctr
#Subsystem       sftp    internal-sftp
#Match Group "ssh-password"
#        PasswordAuthentication yes
#EOF

arch-chroot /mnt mkinitcpio -p linux
arch-chroot /mnt syslinux-install_update -aim

# the user
arch-chroot /mnt useradd -m -g users -G wheel ${newuser}
mkdir /mnt/home/${newuser}/.ssh
touch /mnt/home/${newuser}/.ssh/authorized_keys
chmod 700 /mnt/home/${newuser}/.ssh
chmod 600 /mnt/home/${newuser}/.ssh/authorized_keys
cat <<EOF > /mnt/home/${newuser}/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOOSa+5onVgBFTMby21u0KQnL6ZCAMV6sYVGC1gkQjrsJSjdFTtnCte9raZGJyBB3EcKLy4BtIhcwjMjCTGptNPsneXcGFq81tLQqWj4Lpr+qcemfRHjtiBs+avi6us2EN5K/cMeKDgNl6GrEmRHBrwgrJunVhfU0DuiWN2ycr9ijlCTienV3YM1S/TOCCqygQOH04dCSftd8Vq9HNnDS6JWtlZR1Beo3LjAEuYT4y30zjuRqpMmbCM+7cS4dDlzI8ynALCKh7ExKsUFGlUhDlV/ThFyjfnUfPXk1x6oaTzHf+hJ7GGQATxvunwkrkueewaw99KFcbegXXoSEJEFXt alemaire@norad.fr
EOF
arch-chroot /mnt chown -R ${newuser}:users /home/${newuser}/.ssh
arch-chroot /mnt passwd -d ${newuser} # just in case
arch-chroot /mnt chsh -s /bin/zsh ${newuser}

# enable only user
arch-chroot /mnt passwd -l root
cat <<EOF > /mnt/etc/sudoers.d/wheel
%wheel ALL=(ALL) ALL
EOF

arch-chroot /mnt systemctl enable multi-user.target sshd systemd-networkd systemd-resolved # haveged
ln -sf /run/systemd/resolve/resolv.conf /mnt/etc/resolv.conf

sync
#systemctl reboot

