#!/bin/bash
set -e
source /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

su -c "yaourt -S  adduser lsb-release util-linux --noconfirm" yaourt
chroot ${ROOTFS} useradd ceph
