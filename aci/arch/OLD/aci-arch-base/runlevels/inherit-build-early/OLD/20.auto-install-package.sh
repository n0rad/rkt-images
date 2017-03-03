#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

export package_name=${ACI_NAME#aci-arch-*}
[ x${package_name} == "xbase" ] && exit 0


if [ ! "$(ls -A /dgr/builder/runlevels/build/ 2> /dev/null)" ] && [ ! "$(ls -A /dgr/builder/runlevels/build-late/ 2> /dev/null)" ]; then
#    pacman -Sy ${package_name} --noconfirm
    su -c "yaourt -S  ${package_name} --noconfirm" yaourt
fi


