#!/dgr/bin/busybox sh

useradd -u {{.ssh.id}} {{.ssh.name}}
sed -e "s/{{.ssh.id}}:!:/{{.ssh.id}}:NP:/g" -i /etc/shadow
if [ ! -f /etc/ssh/ssh_host_rsa_key  ]; then
    /usr/bin/ssh-keygen -A
fi
/usr/sbin/sshd -D -e
