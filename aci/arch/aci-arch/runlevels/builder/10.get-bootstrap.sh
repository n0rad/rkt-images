#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

CACHE=/opt/var/cache/pacman/pkg

BOOTSTRAP=/opt
URL=https://archlinux.mirror.pkern.at/iso/latest/
RELEASE_DATE=$(curl -Ls ${URL}|grep -o "[0-9]\{4\}\.[0-9]\{2\}\.[0-9]\{2\}"|head -n1)
FILENAME=archlinux-bootstrap-${RELEASE_DATE}-x86_64.tar.gz
FILE_URL=${URL}/${FILENAME}

mkdir -p ${CACHE} && cd ${CACHE}

# download / extract bootstrap
[ -f ${FILENAME} ] || wget ${FILE_URL}
tar --strip-components 1 -C ${BOOTSTRAP} -xzf ${FILENAME}

# entropy
HAVEGED_FILE=haveged-1.9.1-3-x86_64.pkg.tar.xz
[ -f ${HAVEGED_FILE} ] || wget http://archlinux.mirrors.ovh.net/archlinux/extra/os/x86_64/${HAVEGED_FILE}
tar -C ${BOOTSTRAP} -xf ${HAVEGED_FILE}

# copy pacman.conf
cp ${ACI_HOME}/files/etc/pacman.conf ${BOOTSTRAP}/etc

# prepare to enter bootstrap
cd ${BOOTSTRAP}
cp /etc/resolv.conf etc
mount -t proc /proc proc
mount --rbind /sys sys
mount --rbind /dev dev
mount --rbind /run run

# cache
mount --rbind /opt/var/cache/pacman ${ROOTFS}/var/cache/pacman
mount --rbind /opt/var/lib/pacman/sync ${ROOTFS}/var/lib/pacman/sync

# jump into bootstrap
#chroot ${BOOTSTRAP} /bin/bash
cat << EOF | chroot ${BOOTSTRAP}

ROOTFS=\${ROOTFS#/opt}

mkdir /run/shm # to support debian like /dev/shm

# keyring
haveged
pacman-key --init
pacman-key --populate archlinux
killall haveged

# prepare server list
cat /etc/pacman.d/mirrorlist | cut -d# -f2 > /etc/pacman.d/mirrorlist2
mv /etc/pacman.d/mirrorlist2 /etc/pacman.d/mirrorlist
#sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist #sed is not installed

pacstrap -d \${ROOTFS} base haveged wget less


EOF
