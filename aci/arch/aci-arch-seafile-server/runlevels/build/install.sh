#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

# seafile package sux so :
su -c "yaourt -S python2-pillow python2-setuptools mysql-python libselinux --noconfirm" yaourt
useradd -u 500 seafile


version=${ACI_VERSION%-*}
url="https://bintray.com/artifact/download/seafile-org/seafile/seafile-server_${version}_x86-64.tar.gz"

PROGRAM_PATH="${ROOTFS}/usr/bin"
mkdir -p ${PROGRAM_PATH}
wget $url -O /opt/seafile.tar.gz
cd /opt
tar xzf /opt/seafile.tar.gz

