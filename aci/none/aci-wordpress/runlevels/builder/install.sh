#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

version=${ACI_VERSION%-*}

wget https://fr.wordpress.org/wordpress-${version}-fr_FR.tar.gz
tar xzf wordpress-${version}-fr_FR.tar.gz
mv wordpress ${ROOTFS}
