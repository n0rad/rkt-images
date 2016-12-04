#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

dir=$(dirname $0)

# prepapre pacman conf
cp ${ACI_HOME}/files/etc/pacman.conf /etc/pacman.conf
sed -i "s~\[options\]~\[options\]\nRootDir = ${ROOTFS}~" /etc/pacman.conf


# update pacman
pacman-key --populate archlinux
mkdir -p ${ROOTFS}/var/lib/pacman
pacman -Sy

pacman -S --noconfirm base haveged wget
pacman -Rdd perl --noconfirm

sed -i "s/#Server/Server/g" ${ROOTFS}/etc/pacman.d/mirrorlist
