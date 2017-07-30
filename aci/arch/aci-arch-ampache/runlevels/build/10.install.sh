#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x

su -c "yaourt -S ffmpeg lame vorbis-tools flac faad2 mp3splt --noconfirm" yaourt
su -c "yaourt -S nginx php-fpm php-gd --noconfirm" yaourt
su -c "yaourt -S ampache --noconfirm" yaourt


find /usr/share/webapps/ampache -type d -exec chmod 755 {} \;
chmod 777 /usr/share/webapps/ampache/config

mkdir /config
cp /usr/share/webapps/ampache/config/*.dist /config


#version=${ACI_VERSION%-*}
#
#wget -O ampache.zip https://github.com/ampache/ampache/releases/download/${version}/ampache-${version}_all.zip
#
#mkdir ampache
#cd ampache
#unzip ../ampache.zip
#rm ../ampache.zip
