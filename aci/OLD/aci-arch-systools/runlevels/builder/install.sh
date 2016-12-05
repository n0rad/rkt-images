#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

package_names= \
    atop \
    bash-completion \
    curl \
    dh-autoreconf \
    dialog \
    htop \
    iftop \
    iotop \
    iperf \
    ipmitool \
    iproute \
    iptables \
    iptraf \
    iputils-arping \
    iputils-ping \
    iputils-tracepath \
    itop \
    mtr-tiny \
    multitail \
    ncdu \
    net-tools \
    netcat \
    nmon \
    rsync \
    saidar \
    ssh \
    strace \
    sudo \
    sysstat \
    tcpdump \
    tcpflow \
    telnet \
    tree \
    vim \
    wget \
    dnsutils

su -c "yaourt -S ${package_names} --noconfirm" yaourt
