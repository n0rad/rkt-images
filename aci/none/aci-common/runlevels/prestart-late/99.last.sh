#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x


if isLevelEnabled "debug"; then
    echo ""
    echo "Pre-victory !"
    echo ""
fi
