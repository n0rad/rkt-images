#!/bin/bash
set -e
source /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x




#apt-get update
#apt-cache search librados librbd1 nss
##apt-get install -qy librados2 librbd1
#apt-get install -qy librados-dev librbd-dev
PROGRAM_PATH="$ROOTFS/opt/bin"
mkdir -p ${PROGRAM_PATH}
#
#cp "/usr/lib/x86_64-linux-gnu/librados.so.2" ${ROOTFS}/usr/lib/librados.so.2
#cp "/usr/lib/x86_64-linux-gnu/librbd.so.1" ${ROOTFS}/usr/lib/librbd.so.1
#cp "/usr/lib/x86_64-linux-gnu/libnss3.so" ${ROOTFS}/usr/lib/.
#cp "/usr/lib/x86_64-linux-gnu/libsmime3.so" ${ROOTFS}/usr/lib/.
#
#
#ln "/usr/lib/x86_64-linux-gnu/librados.so.2" /usr/lib/librados.so.2
#ln "/usr/lib/x86_64-linux-gnu/librbd.so.1" /usr/lib/librbd.so.1
#ln "/usr/lib/x86_64-linux-gnu/libnss3.so" /usr/lib/.
#ln "/usr/lib/x86_64-linux-gnu/libsmime3.so" /usr/lib/.
#
#ls -ll /usr/lib/librbd.so.1
#find / -name libnss*.a
#ls -ll /usr/lib/libnss*

export GOPATH=/go
export PKG_GONAME="github.com/containerops/dockyard"
go get ${PKG_GONAME}
cd /go/src/${PKG_GONAME}
CGO_ENABLED=0
go build -a -tags netgo --ldflags '-w -s' # -extldflags "-s -lm -lstdc++ -lpthread -lnss3 -static  -frtti --verbose"'
mv ${PKG_GONAME##*/} ${PROGRAM_PATH}/${PKG_GONAME##*/}
chmod +x ${PROGRAM_PATH}/${PKG_GONAME##*/}
for i in $(ldd ${PROGRAM_PATH}/${PKG_GONAME##*/} |awk '{print $3}' |grep -v '^$');do mkdir -p ${ROOTFS}${i%/*};cp ${i} ${ROOTFS}/${i};cp ${i} ${ROOTFS}/usr/lib/.; done
mkdir -p ${ROOTFS}/usr/lib/x86_64-linux-gnu/.
#cp "/usr/lib/x86_64-linux-gnu/librados.so.2" ${ROOTFS}/usr/lib/librados.so.2
#cp "/usr/lib/x86_64-linux-gnu/librbd.so.1" ${ROOTFS}/usr/lib/librbd.so.1
#cp "/usr/lib/x86_64-linux-gnu/libnss3.so" ${ROOTFS}/usr/lib/.
#cp "/usr/lib/x86_64-linux-gnu/libsmime3.so" ${ROOTFS}/usr/lib/.
#cp "/usr/lib/x86_64-linux-gnu/libnspr4.so" ${ROOTFS}/usr/lib/.
#cp "/lib/x86_64-linux-gnu/libuuid.so.1" ${ROOTFS}/usr/lib/.
#cp "/usr/lib/x86_64-linux-gnu/libboost_thread.so.1.55.0" ${ROOTFS}/usr/lib/.
#cp "/usr/lib/x86_64-linux-gnu/libboost_system.so.1.55.0" ${ROOTFS}/usr/lib/.
#cp "/usr/lib/x86_64-linux-gnu/libstdc++.so.6" ${ROOTFS}/usr/lib/.
#cp "/lib/x86_64-linux-gnu/libgcc_s.so.1" ${ROOTFS}/usr/lib/.
#cp "/lib/x86_64-linux-gnu/libm.so.6" ${ROOTFS}/usr/lib/.


rm -rf /go
