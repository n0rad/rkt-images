#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

pacman -Sy openssh pam --noconfirm

#sed -i -e 's/^UsePAM yes/UsePAM no/g' ${ROOTFS}/etc/ssh/sshd_config
