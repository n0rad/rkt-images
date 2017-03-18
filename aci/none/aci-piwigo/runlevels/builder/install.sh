#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x


version=${ACI_VERSION%-*}

wget -O piwigo.zip http://piwigo.org/download/dlcounter.php?code=${version}
unzip piwigo.zip
mv piwigo ${ROOTFS}
