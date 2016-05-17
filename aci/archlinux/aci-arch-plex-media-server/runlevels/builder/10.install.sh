#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

# install tools to builder
cp /etc/pacman.conf /etc/pacman.conf.save
sed -i 's/^\(RootDir\s*=\s*\).*$/\1\//' /etc/pacman.conf
pacman -Sy
su -c "yaourt -S libelf --noconfirm" yaourt
su -c "yaourt -S prelink --noconfirm" yaourt

# install
cp /etc/pacman.conf.save /etc/pacman.conf
su -c "yaourt -S plex-media-server --noconfirm" yaourt

sed -i '/export LC_ALL=/s/^/#/' ${ROOTFS}/opt/plexmediaserver/start.sh
sed -i '/export LANG=/s/^/#/' ${ROOTFS}/opt/plexmediaserver/start.sh

app="plex"
user=$(cat ${ROOTFS}/etc/passwd | grep ${app} | cut -f3 -d:)
group=$(cat ${ROOTFS}/etc/passwd | grep ${app} | cut -f4 -d:)

mkdir ${ROOTFS}/root/Library
chown $user:$group ${ROOTFS}/root/Library
