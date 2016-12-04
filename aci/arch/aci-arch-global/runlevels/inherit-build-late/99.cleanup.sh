#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

pacman -Qdt --noconfirm

rm -Rf ${ROOTFS}/var/cache/pacman/
rm -Rf ${ROOTFS}/var/lib/pacman/sync/*
rm -Rf ${ROOTFS}/boot/*