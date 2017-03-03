#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x


pacman -Sy yaourt sudo --noconfirm
echo "yaourt:x:20002:20002:yaourt:/home/yaourt:/usr/bin/sh" >> /etc/passwd
echo "yaourt:x:20002:" >> /etc/group
echo "yaourt:x:20002::::::" >> /etc/shadow

echo "Cmnd_Alias  PACMAN = /usr/bin/pacman, /usr/bin/yaourt
%yaourt ALL=(ALL) NOPASSWD: PACMAN" > /etc/sudoers


# repack as tar
sed -i -- "s/PKGEXT='.pkg.tar.xz'/PKGEXT='.pkg.tar'/g" /etc/makepkg.conf


#ln -s /proc/self/fd /dev/fd
#ln -s /proc/self/fd/0 /dev/stdin
#ln -s /proc/self/fd/1 /dev/stdout
#ln -s /proc/self/fd/2 /dev/stderr
