#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

package_name=${ACI_NAME#aci-arch-*}
[ x${package_name} == "xyaourt-auto" ] && exit 0
su -c "yaourt -S  ${package_name} --noconfirm" yaourt
