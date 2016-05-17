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
