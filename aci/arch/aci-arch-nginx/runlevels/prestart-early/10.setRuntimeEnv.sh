#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

cpu_number=$(nproc)

mkdir -p /dgr/attributes/prestart
cat > /dgr/attributes/prestart/prestart.yml <<EOF
---
default:
  os:
    cpu_number: '$cpu_number'
    cpu_processes: '$(($cpu_number*1024))'
EOF

