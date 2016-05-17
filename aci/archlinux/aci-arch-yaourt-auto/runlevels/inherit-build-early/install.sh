#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x
/dgr/bin/templater -o TEMPLATER_OVERRIDE -t / /dgr
package_name=${ACI_NAME#aci-arch-*}
su -c "yaourt -yyS  ${package_name} --noconfirm" yaourt
