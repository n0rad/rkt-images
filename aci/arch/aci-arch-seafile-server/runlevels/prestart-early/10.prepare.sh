#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x


# seafile require to have all conf in seafile-server/.. so we copy seafile-server in mount point
rm -Rf /seafile/seafile-server
cp -r /seafile-server /seafile/seafile-server
