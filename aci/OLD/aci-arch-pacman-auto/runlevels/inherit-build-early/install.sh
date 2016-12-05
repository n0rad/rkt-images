#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

package_name=${ACI_NAME#aci-arch-*}
[ x${package_name} == "xpacman-auto" ] && exit 0

pacman -Sy ${package_name} --noconfirm
