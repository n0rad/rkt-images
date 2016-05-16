#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

# nproc
pacman -S coreutils --noconfirm

pacman -S nginx --noconfirm


mkdir -p /etc/nginx/conf.d
chmod 777 /etc/nginx/conf.d