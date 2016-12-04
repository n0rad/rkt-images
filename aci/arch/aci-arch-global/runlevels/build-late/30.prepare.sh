#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

# time
rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# locale
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen

# key
echo "KEYMAP=fr" > /etc/vconsole.conf

# required by yaourt
ln -s /proc/self/fd /dev/fd
