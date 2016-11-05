#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

/usr/bin/acserver -port {{.acserver.port}} {{if .acserver.unsigned}}-unsigned{{end}} /data {{.acserver.username}} {{.acserver.password}}
