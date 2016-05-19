#!/dgr/bin/busybox sh
mkdir -p /var/lib/ceph/mon/combien_pese_un_hister-node1
chown ceph: -R /var/lib/ceph/mon
monmaptool --create --add node1 {{.pod.ip}} --fsid aa3b3a75-0e46-4821-bde6-0c97ae5b9589 /tmp/monmap
su -m ceph -c 'ceph-mon --cluster combien_pese_un_hister --mkfs -i node1 --monmap /tmp/monmap --keyring /tmp/combien_pese_un_hister.mon.keyring'