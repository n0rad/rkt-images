#!/dgr/bin/busybox sh
set -e
. /dgr/bin/functions.sh
isLevelEnabled "debug" && set -x


wget https://tt-rss.org/gitlab/fox/tt-rss/repository/archive.zip
unzip archive.zip

# ttrss
mv tt-rss.git ${ROOTFS}/ttrss

# feedly theme
wget https://github.com/levito/tt-rss-feedly-theme/archive/master.zip
unzip master.zip
mv tt-rss-feedly-theme-master/feedly* ${ROOTFS}/ttrss/themes

# version
date=$(date -u '+%Y%m%d_%H%M%S')
cat > /dgr/builder/attributes/version.yml <<EOF
default:
  date: "${date}"
EOF
