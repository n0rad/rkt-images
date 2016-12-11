#!/bin/bash
set -x
set -e

cd /bin
wget https://raw.githubusercontent.com/blablacar/dgr/master/scripts/dgr-update.sh
chmod +x dgr-update.sh
./dgr-update.sh




version="v1.21.0"
filename="rkt-${version}.tar.gz"
url="https://github.com/coreos/rkt/releases/download/${version}/${filename}"

$(rkt version | grep "${version}") || {
    mkdir -p "/tmp/rkt"
    cd "/tmp/rkt"
	wget $url
	tar xvzf "${filename}" --strip=1
	cp rkt stage1* /bin/
	cd -
}
