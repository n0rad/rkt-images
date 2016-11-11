#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

version=$(pacman -Qi ${ACI_NAME#aci-arch-*} 2> /dev/null | grep Version | cut -f2 -d: | tr -d '[[:space:]]')
date=$(date -u '+%Y%m%d_%H%M%S')

cat > /dgr/builder/attributes/version.yml <<EOF
default:
  version: "${version}"
  date: "${date}"
EOF
