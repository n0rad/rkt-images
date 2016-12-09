#!/dgr/bin/busybox sh
#set -e   #cleanup can fail
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

rm -Rf /srv/* # so we can replace by links
