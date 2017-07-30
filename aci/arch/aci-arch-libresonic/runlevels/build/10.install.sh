#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

su -c "yaourt -S jre8-openjdk ffmpeg flac lame --noconfirm" yaourt
su -c "yaourt -S libresonic --noconfirm" yaourt

mkdir /libresonic

mv /var/lib/libresonic/libresonic.war /libresonic
mv /var/lib/libresonic/libresonic.sh /libresonic
mv /var/lib/libresonic/libresonic.service /libresonic
