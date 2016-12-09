#!/dgr/bin/busybox sh
echo "compute server-id variable from IP"
export SERVERID=$(/usr/bin/perl -e"print unpack 'N', pack 'C4', split '\.', '$IP';;")

mkdir /dgr/attributes/prestart
cat > /dgr/attributes/prestart/prestart.yml <<EOF
---
default:
  mysql:
    replication:
      server_id: '$SERVERID'
EOF
