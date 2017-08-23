#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

# seafile package sux so :
su -c "yaourt -Sy ffmpeg python2-pillow python2-setuptools mysql-python libselinux cronie --noconfirm" yaourt
groupadd -g 500 seafile
useradd -u 500 -g 500 seafile

version=${ACI_VERSION%-*}
url="https://download.seadrive.org/seafile-server_${version}_x86-64.tar.gz"

wget $url -O /seafile.tar.gz
mkdir /seafile-server && cd /seafile-server
tar --strip=1 -xzf /seafile.tar.gz
rm /seafile.tar.gz
