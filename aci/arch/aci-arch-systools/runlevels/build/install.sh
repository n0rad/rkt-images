#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

package_names=$(echo " \
    openssh \
    zsh \
    oh-my-zsh-git \
    fuse \
    atop \
    bash-completion \
    htop \
    iftop \
    iotop \
    iperf \
    ipmitool \
    iproute \
    iptraf-ng \
    traceroute \
    itop \
    mtr \
    multitail \
    ncdu \
    net-tools \
    netcat \
    nmon \
    strace \
    sysstat \
    tcpdump \
    tcpflow \
    tree \
    vim \
    dnsutils \
    libstatgrab \
    ")

su -c "yaourt -S ${package_names} --noconfirm" yaourt
