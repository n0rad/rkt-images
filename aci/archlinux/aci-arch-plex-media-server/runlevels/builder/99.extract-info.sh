#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

app="plex"

user=$(cat ${ROOTFS}/etc/passwd | grep ${app} | cut -f3 -d:)
group=$(cat ${ROOTFS}/etc/passwd | grep ${app} | cut -f4 -d:)

cat > /dgr/builder/attributes/version.yml <<EOF
default:
  user: ${user}
  group: ${group}
EOF

exit 0
