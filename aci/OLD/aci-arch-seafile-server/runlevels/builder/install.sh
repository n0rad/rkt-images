#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

su -c "yaourt -S jansson --noconfirm" yaourt
su -c "yaourt -S seafile-server --noconfirm" yaourt
