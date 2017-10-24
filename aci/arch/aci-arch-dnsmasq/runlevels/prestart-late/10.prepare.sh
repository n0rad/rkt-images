#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

# check config is ok
dnsmasq --test

cd /data
mkdir -p /data/archlinux
mkdir -p /pxe

# download iso
URL=https://archlinux.mirror.pkern.at/iso/latest/
RELEASE_DATE=$(curl -Ls ${URL}|grep -o "[0-9]\{4\}\.[0-9]\{2\}\.[0-9]\{2\}"|head -n1)
FILENAME=archlinux-${RELEASE_DATE}-x86_64.iso
FILE_URL=${URL}/${FILENAME}
[ -f ${FILENAME} ] || wget ${FILE_URL} || true

LATEST=$(ls archlinux-*-x86_64.iso | sort -r | head -n1)

mount -o loop,ro ${LATEST} /data/archlinux
mount -t overlay overlay -olowerdir=/data/archlinux:/source  /pxe
