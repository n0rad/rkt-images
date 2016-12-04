#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

su -c "yaourt -S plex-media-server --noconfirm" yaourt

app="plex"
user=$(cat ${ROOTFS}/etc/passwd | grep ${app} | cut -f3 -d:)
group=$(cat ${ROOTFS}/etc/passwd | grep ${app} | cut -f4 -d:)

mkdir ${ROOTFS}/root/Library
chown ${user}:${group} ${ROOTFS}/root/Library
