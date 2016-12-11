#!/bin/bash
set -x
set -e

cd /bin
wget https://raw.githubusercontent.com/blablacar/dgr/master/scripts/dgr-update.sh
chmod +x dgr-update.sh
./dgr-update.sh




version="v1.0.0"
filename="rkt.yml-${version}.tar.gz"
url="https://github.com/coreos/rkt.yml/releases/download/${version}/${filename}"

$(rkt version | grep "${version}") || {
    mkdir -p "/tmp/rkt.yml"
    cd "/tmp/rkt.yml"
	wget $url
	tar xvzf "${filename}" --strip=1
	cp rkt stage1* /bin/
	cd -
}
