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
    dgr -W ${1} -L debug clean install
}


# none
buildAci ${dir}/aci/aci-base
buildAci ${dir}/aci/aci-libc

# archlinux
buildAci ${dir}/aci/aci-arch-bootstrap
buildAci ${dir}/aci/aci-arch-pacman
buildAci ${dir}/aci/aci-arch-yaourt

buildAci ${dir}/aci/aci-arch-nginx
buildAci ${dir}/aci/aci-arch-git
buildAci ${dir}/aci/aci-arch-go
buildAci ${dir}/aci/aci-arch-dockyard
#buildAci ${dir}/aci/aci-arch-seafile-server
