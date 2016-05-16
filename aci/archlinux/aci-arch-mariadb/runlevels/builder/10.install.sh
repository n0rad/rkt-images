#!/bin/bash

# support repsonse file (preseed)
#apt-get install -y debconf-utils
#mkdir -p /var/cache/local/preseeding/
#cat > /var/cache/local/preseeding/mariadb-server.seed<<EOF
## Unable to set password for the MariaDB "root" user
#mariadb-server-10.0	mysql-server/error_setting_password	error	false
#mariadb-server-10.0	mysql-server-5.1/nis_warning	note
#mariadb-server-10.0	mariadb-server-10.0/really_downgrade	boolean	false
## Start the MariaDB server on boot?
#mariadb-server-10.0	mysql-server-5.1/start_on_boot	boolean	true
#mariadb-server-10.0	mariadb-server-10.0/really_downgrade	boolean	false
## Remove all MariaDB databases?
#mariadb-server-10.0	mysql-server-5.1/postrm_remove_databases	boolean	true
## New password for the MariaDB "root" user:
#mariadb-server-10.0	mysql-server/root_password	select
## Repeat password for the MariaDB "root" user:
#mariadb-server-10.0	mysql-server/root_password_again	select
#mariadb-server-10.0	mysql-server/password_mismatch	error	false
#mariadb-server-10.0	mysql-server/no_upgrade_when_using_ndb	error	true
#EOF
#/usr/bin/debconf-set-selections /var/cache/local/preseeding/mariadb-server.seed

# useradd
pacman -S shadow --noconfirm

# install mariadb
pacman -S mariadb --noconfirm
#DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server-10.0

# install tooling
#pacman -S glibc go --noconfirm
#apt-get install -y percona-xtrabackup

# Cleaning
#apt-get remove --purge -y debconf-utils
#rm -rf /var/lib/mysql/*
#apt-get clean