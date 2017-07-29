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



mkdir -p '/plex-plugins'

wget https://github.com/ZeroQI/Absolute-Series-Scanner/archive/master.zip
unzip master.zip -d '/tmp'
mv /tmp/Absolute-Series-Scanner-master/* '/plex-plugins'
rm master.zip

wget https://github.com/ZeroQI/Hama.bundle/releases/download/v1.0/Plug-in.Support.folders.zip
unzip Plug-in.Support.folders.zip -d '/plex-plugins'
rm Plug-in.Support.folders.zip

mkdir -p '/plex-plugins/Plug-ins'
wget https://github.com/ZeroQI/Hama.bundle/archive/master.zip
mv master.zip '/plex-plugins/Plug-ins/Hama.bundle'

