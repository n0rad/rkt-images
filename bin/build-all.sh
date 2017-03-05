#!/bin/bash
set -e
dir=$( dirname $0 )

rootAcis=${dir}/../aci

 : ${cmd:=clean install}


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
    dgr -W ${1} ${cmd}
}


# none
buildAci ${rootAcis}/none/aci-common
buildAci ${rootAcis}/none/aci-glibc
buildAci ${rootAcis}/none/aci-acserver
buildAci ${rootAcis}/none/aci-ttrss
buildAci ${rootAcis}/none/aci-wordpress

# archlinux
buildAci ${rootAcis}/arch/aci-arch
buildAci ${rootAcis}/arch/aci-arch-script
buildAci ${rootAcis}/arch/aci-arch-dhcp
buildAci ${rootAcis}/arch/aci-arch-bind
buildAci ${rootAcis}/arch/aci-arch-qemu
buildAci ${rootAcis}/arch/aci-arch-bftpd
buildAci ${rootAcis}/arch/aci-arch-mariadb
buildAci ${rootAcis}/arch/aci-arch-nginx
buildAci ${rootAcis}/arch/aci-arch-php-fpm
buildAci ${rootAcis}/arch/aci-arch-seafile-server
buildAci ${rootAcis}/arch/aci-arch-plex-media-server

#buildAci ${dir}/aci/arch/aci-arch-base-buildroot

echo -e "\n\033[0;32mEverything looks good !\033[0m\n"
