#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

package_name=${ACI_NAME#aci-arch-*}

pacman -S ${package_name} --noconfirm
