#!/dgr/bin/busybox sh
{{if (eq .ceph.node.type "monitor" ) }}
mkdir -p /var/lib/ceph/mon/{{.ceph.cluster.name}}-node1
chown ceph: -R /var/lib/ceph/mon
monmaptool --create --add node1 {{.pod.ip}} --fsid {{.ceph.fsid}} /tmp/monmap
su -m ceph -c 'ceph-mon --cluster {{.ceph.cluster.name}} --mkfs -i node1 --monmap /tmp/monmap --keyring /tmp/{{.ceph.cluster.name}}.mon.keyring'
{{else if  ( eq .ceph.node.type "osd" )}}
ceph osd create {{.ceph.fsid}}
mkdir -p /var/lib/ceph/osd/{{.ceph.cluster.name}}-{{.ceph.node.osd_number}}
ceph-osd -i {{.ceph.node.osd_number}} --mkfs --mkkey --cluster {{.ceph.cluster.name}}
ceph auth add osd.{{.ceph.node.osd_number}} osd 'allow *' mon 'allow rwx' -i /var/lib/ceph/osd/{{.ceph.cluster.name}}-{{.ceph.node.osd_number}}/keyring
chown ceph: -R /var/lib/ceph/osd
ceph osd crush add-bucket {{.ceph.node.name}} host
ceph osd crush move node1 root=default
{{else if  ( eq .ceph.node.type "mds" )}}
{{- end -}}
