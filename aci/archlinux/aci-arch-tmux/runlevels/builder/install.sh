#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

mkdir -p $ROOTFS/usr/share/locale $ROOTFS/etc
#ln -s /etc/locale.alias /usr/share/locale/locale.alias
ls -ll $ROOTFS/etc

su -c 'yaourt -yyS glibc --noconfirm' yaourt
echo 'en_US.UTF-8 UTF-8' > $ROOTFS/etc/locale.gen
touch  $ROOTFS/usr/share/locale/locale.alias
find $ROOTFS/bin 
#chroot $ROOTFS /bin/ls /usr/bin/locale-gen
su -c 'yaourt -yyS tmux --noconfirm' yaourt
su -c 'yaourt -yyS sed --noconfirm' yaourt
cp -a /usr/sbin/rm $ROOTFS/sbin/rm
cp -a /usr/share/i18n/charmaps/UTF-8* $ROOTFS/usr/share/i18n/charmaps/UTF-8*
cd  $ROOTFS/usr/share/i18n/charmaps
gunzip UTF-8.gz
chroot $ROOTFS locale -a
chroot $ROOTFS /usr/bin/locale-gen
