#!/bin/bash
set -e
source /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x


#PROGRAM_PATH="$ROOTFS/opt/bin"
#mkdir -p ${PROGRAM_PATH}

export GOPATH=${ROOTFS}
export PKG_GONAME="github.com/containerops/dockyard"
go get ${PKG_GONAME}
cd ${GOPATH}/src/${PKG_GONAME}

CGO_ENABLED=0
go build -a -tags netgo --ldflags '-w -s' # -extldflags "-s -lm -lstdc++ -lpthread -lnss3 -static  -frtti --verbose"'

mv ${PKG_GONAME##*/} ${PROGRAM_PATH}/${PKG_GONAME##*/}
