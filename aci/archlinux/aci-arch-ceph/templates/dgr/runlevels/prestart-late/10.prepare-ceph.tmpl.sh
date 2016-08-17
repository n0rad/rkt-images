#!/dgr/bin/busybox sh

source /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

{{if (eq .ceph.node.type "monitor" ) }}

mkdir -p /opt/ceph/mon/{{.ceph.cluster.name}}-mon{{.ceph.node.mon_number}}
chown ceph: -R  /opt/ceph/mon
monmaptool --create --add mon{{.ceph.node.mon_number}} {{.pod.ip}} --fsid {{.ceph.fsid}} /tmp/monmap
su -m ceph -c 'ceph-mon --cluster {{.ceph.cluster.name}} --mkfs -i mon{{.ceph.node.mon_number}}  --monmap /tmp/monmap --keyring /tmp/{{.ceph.cluster.name}}.mon.keyring'

{{else if  ( eq .ceph.node.type "osd" )}}

ceph --cluster {{.ceph.cluster.name}} osd create {{.ceph.fsid}} {{.ceph.node.osd_number}}
mkdir -p  /opt/ceph/osd/{{.ceph.cluster.name}}-osd{{.ceph.node.osd_number}}
ceph-osd -i {{.ceph.node.osd_number}} --mkfs --mkkey --cluster {{.ceph.cluster.name}}
#ceph-authtool /var/lib/ceph/osd/{{.ceph.cluster.name}}.keyring --create-keyring --gen-key -n client.osd --cap mon 'allow profile osd'
ceph --cluster {{.ceph.cluster.name}} auth del osd{{.ceph.node.osd_number}}
ceph --cluster {{.ceph.cluster.name}} auth add osd{{.ceph.node.osd_number}} osd 'allow *' mon 'allow rwx' -i /opt/ceph/osd/{{.ceph.cluster.name}}-osd{{.ceph.node.osd_number}}/keyring
chown ceph: -R /opt/ceph/osd
ceph --cluster {{.ceph.cluster.name}} osd crush add-bucket {{.ceph.node.name}} host
ceph --cluster {{.ceph.cluster.name}} osd crush move  {{.ceph.node.name}} root=default

{{else if  ( eq .ceph.node.type "mds" )}}

mkdir  -p /opt/ceph/mds/{{.ceph.cluster.name}}-mds{{.ceph.node.mon_number}}

if [ ! -e  /opt/ceph/mds/mds{{.ceph.node.mds_number}}/keyring ]; then
	ceph --cluster {{.ceph.cluster.name}}  /etc/ceph/{{.ceph.cluster.name}}.client.admin.keyring auth get-or-create mds{{.ceph.node.mds_number}} osd 'allow rwx' mds 'allow' mon 'allow profile mds' -o  /opt/ceph/mds/{{.ceph.cluster.name}}-mds.{{.ceph.node.mds_number}}/keyring
	chown ceph.   /opt/ceph/mds/{{.ceph.cluster.name}}-mds{{.ceph.node.mds_number}}/keyring
	chmod 600   /opt/ceph/mds/{{.ceph.cluster.name}}-mds{{.ceph.node.mds_number}}/keyring
fi

{{- end -}}
