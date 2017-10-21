#!/bin/bash
PS3='Select Environment: '
options=("Local VM" "Other")
select opt in "${options[@]}"
do
  case "$opt" in
    "VirtualBox")
      DISK=sda
      PORT=2222
      HOST=127.0.0.1
      break
      ;;
    "Other")
      DISK=vda
      PORT=22
      echo -n "HOST: "
      read HOST
      break
      ;;
    *) echo Invalid;;
  esac
done
echo DISK="$DISK", PORT="$PORT", HOST="$HOST"
HOST_ROOT="root@$HOST"
PUBKEY=$(cat ./id_rsa.pub)
# copy your public key, so can ssh without a password later on
ssh -tt -p "$PORT" "$HOST_ROOT" "mkdir -m 700 ~/.ssh; echo $PUBKEY > ~/.ssh/authorized_keys; chmod 600 ~/.ssh/authorized_keys"
# copy install scripts from ./root folder
scp -P "$PORT" ./root/* "$HOST_ROOT:/root"
# run the install script remotely
ssh -tt -p "$PORT" "$HOST_ROOT" "./install.sh $DISK"














#!/bin/bash
DISK="/dev/$1"
PARTITION="${DISK}1"
echo DISK="$DISK", PARTITION="$PARTITION"
parted -s "$DISK" mklabel msdos
parted -s -a optimal "$DISK" mkpart primary ext4 0% 100%
parted -s "$DISK" set 1 boot on
mkfs.ext4 -F "$PARTITION"
# you can find your closest server from: https://www.archlinux.org/mirrorlist/all/
echo 'Server = http://mirror.internode.on.net/pub/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
mount "$PARTITION" /mnt
pacman -Syy
# would recommend to use linux-lts kernel if you are running a server environment, otherwise just use "linux"
pacstrap /mnt $(pacman -Sqg base | sed 's/^linux$/&-lts/') base-devel grub openssh sudo ntp wget vim
genfstab -p /mnt >> /mnt/etc/fstab
cp ./chroot.sh /mnt
cp ~/.ssh/authorized_keys /mnt
arch-chroot /mnt ./chroot.sh "$DISK"
rm /mnt/chroot.sh
rm /mnt/authorized_keys
umount -R /mnt
systemctl reboot







#!/bin/bash
HOST=myhostname
USERNAME=myusername
HOME_DIR="/home/${USERNAME}"
SWAP_SIZE=4G
echo DISK="$1", HOST="$HOST", USERNAME="$USERNAME", HOME_DIR="$HOME_DIR"
# grub as a bootloader
grub-install --target=i386-pc --recheck "$1"
# This makes the grub timeout 0, it's faster than 5 :)
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
# run these following essential service by default
systemctl enable sshd.service
systemctl enable dhcpcd.service
systemctl enable ntpd.service
echo "$HOST" > /etc/hostname
# inject vimrc config to default user dir if you like vim
echo -e 'runtime! archlinux.vim\nsyntax on' > /etc/skel/.vimrc
# adding your normal user with additional wheel group so can sudo
useradd -m -G wheel -s /bin/bash "$USERNAME"
# adding public key both to root and user for ssh key access
mkdir -m 700 "$HOME_DIR/.ssh"
mkdir -m 700 /root/.ssh
cp /authorized_keys "/$HOME_DIR/.ssh"
cp /authorized_keys /root/.ssh
chown -R "$USERNAME:$USERNAME" "$HOME_DIR/.ssh"
# adjust your timezone here
ln -f -s /usr/share/zoneinfo/Australia/Melbourne /etc/localtime
hwclock --systohc
# adjust your name servers here if you don't want to use google
echo 'name_servers="8.8.8.8 8.8.4.4"' >> /etc/resolvconf.conf
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
locale-gen
# because we are using ssh keys, make sudo not ask for passwords
echo 'root ALL=(ALL) ALL' > /etc/sudoers
echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
# I like to use vim :)
echo -e 'EDITOR=vim' > /etc/environment
# creating the swap file, if you have enough RAM, you can skip this step
fallocate -l "$SWAP_SIZE" /swapfile
chmod 600 /swapfile
mkswap /swapfile
echo /swapfile none swap defaults 0 0 >> /etc/fstab
# auto-complete these essential commands
echo complete -cf sudo >> /etc/bash.bashrc
echo complete -cf man >> /etc/bash.bashrc