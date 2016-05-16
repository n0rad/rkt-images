#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

package_name=${ACI_NAME#aci-arch-*}
su -c "yaourt -S ${package_name} --noconfirm" yaourt
