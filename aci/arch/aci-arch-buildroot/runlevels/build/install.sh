#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

# dependencies
pacman -Sy python --noconfirm


version=${ACI_VERSION%-*}
url="https://buildroot.org/downloads/buildroot-${version}.tar.gz"

echo_green "Download buildroot"
curl -Ls ${url} -o ${ROOTFS}/buildroot.tar.gz

echo_green "Extract buildroot"
mkdir ${ROOTFS}/buildroot && cd ${ROOTFS}/buildroot
tar --strip 1 -xzf ${ROOTFS}/buildroot.tar.gz
rm ${ROOTFS}/buildroot.tar.gz
