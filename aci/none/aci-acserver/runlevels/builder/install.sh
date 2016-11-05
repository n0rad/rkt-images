#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

version=${ACI_VERSION%-*}
url="https://github.com/blablacar/acserver/releases/download/v${version}/acserver-v${version}-linux-amd64.tar.gz"

PROGRAM_PATH="${ROOTFS}/usr/bin"
mkdir -p ${PROGRAM_PATH}
curl -Ls ${url} | tar -C ${PROGRAM_PATH} --strip 1 -xzvf -
chmod +x ${PROGRAM_PATH}/acserver
