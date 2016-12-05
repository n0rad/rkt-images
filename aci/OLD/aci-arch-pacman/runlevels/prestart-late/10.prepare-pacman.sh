#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

rm -fr /etc/pacman.d/gnupg

pacman-key --init
pacman-key --populate archlinux
mkdir -p ${ROOTFS}/var/lib/pacman
pacman -Sy
