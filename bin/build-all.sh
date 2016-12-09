#!/bin/bash
set -e
dir=$( dirname $0 )

rootAcis=${dir}/../aci

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
buildAci ${rootAcis}/none/aci-common
buildAci ${rootAcis}/none/aci-glibc
buildAci ${rootAcis}/none/aci-ttrss
buildAci ${rootAcis}/none/aci-acserver

# archlinux
buildAci ${rootAcis}/arch/aci-arch-bootstrap
buildAci ${rootAcis}/arch/aci-arch-base
buildAci ${rootAcis}/arch/aci-arch-base-devel

buildAci ${rootAcis}/arch/aci-arch-base-bftpd
buildAci ${rootAcis}/arch/aci-arch-base-mariadb
buildAci ${rootAcis}/arch/aci-arch-base-nginx
buildAci ${rootAcis}/arch/aci-arch-base-php-fpm

#buildAci ${dir}/aci/arch/aci-arch-base-plex-media-server
#buildAci ${dir}/aci/arch/aci-arch-base-seafile-server
#buildAci ${dir}/aci/arch/aci-arch-base-buildroot

echo -e "\n\033[0;32mEverything looks good !\033[0m\n"
