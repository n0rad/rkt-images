#!/bin/bash
set -e
dir=$( dirname $0 )

if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	exit 1
fi

#for i in $(ls -d ${dir}/*/ | sort -r); do
#  if [ "$i" != "${dir}/aci-base/" ]; then
#    echo -e "\e[101mBuilding ${i%%/} :\e[0;m"
#    dgr -W ${i} -L debug clean install
#  fi
#done

buildAci() {
    echo -e "\n\n\e[0;30;42mBuilding aci : ${1}\e[0m\n\n"
    sleep 1
    dgr -W ${1} clean install
}


# none
buildAci ${dir}/aci/none/aci-base
buildAci ${dir}/aci/none/aci-libc

# archlinux
buildAci ${dir}/aci/archlinux/aci-arch-bootstrap
buildAci ${dir}/aci/archlinux/aci-arch-pacman
buildAci ${dir}/aci/archlinux/aci-arch-pacman-auto
buildAci ${dir}/aci/archlinux/aci-arch-yaourt
buildAci ${dir}/aci/archlinux/aci-arch-yaourt-auto
buildAci ${dir}/aci/archlinux/aci-arch-minimal

buildAci ${dir}/aci/archlinux/aci-arch-bftpd
buildAci ${dir}/aci/archlinux/aci-arch-bind
buildAci ${dir}/aci/archlinux/aci-arch-dhcp
buildAci ${dir}/aci/archlinux/aci-arch-nginx
buildAci ${dir}/aci/archlinux/aci-arch-git
buildAci ${dir}/aci/archlinux/aci-arch-go
#buildAci ${dir}/aci/archlinux/aci-arch-ceph
#buildAci ${dir}/aci/archlinux/aci-arch-redis
#buildAci ${dir}/aci/archlinux/aci-arch-jdk
#buildAci ${dir}/aci/archlinux/aci-arch-jre
#buildAci ${dir}/aci/archlinux/aci-arch-mariadb

#buildAci ${dir}/aci/archlinux/aci-arch-dockyard
#buildAci ${dir}/aci/archlinux/aci-arch-seafile-server

echo -e "\n\033[0;32mEverything looks good !\033[0m\n"
