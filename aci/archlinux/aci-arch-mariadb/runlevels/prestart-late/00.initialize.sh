#!/dgr/bin/busybox sh

BLUE='\e[94m'
NC='\e[0m'

echo -e "${BLUE}### Read environment file (populated by confd)${NC}"
source /run/env.sh

# first install
if [ ! -d /var/lib/mysql/data  ]; then
  echo -e "${BLUE}### Create MySQL OS user and group${NC}"
  useradd mysql -U

  echo -e "${BLUE}### Create directories${NC}"
  mkdir -p /var/lib/mysql/tmp
  mkdir -p /var/lib/mysql/data
  chown mysql. /var/lib/mysql/ -R
  
  mkdir -p /var/log/mysql
  chown mysql. /var/log/mysql -R

  echo -e "${BLUE}### Boostrap MySQL${NC}"
  /usr/bin/mysql_install_db --defaults-file=/etc/mysql/my.cnf

  echo -e "${BLUE}### Start MySQL to run post install commands${NC}"
  /usr/sbin/mysqld &
  
  i=0
  while [ $i -lt 10 ]
  do
    /usr/bin/mysqladmin --user='root' --password='' ping>&/dev/null
    if [ $? -eq 0 ]; then
      echo -e "${BLUE}## MySQL is Started!${NC}"
      break
    else
      sleep 5
      echo -e "${BLUE}## Waiting MySQL to start...${NC}"
    fi
    i=$[$i+1]
  done
  
  echo -e "${BLUE}### Create MySQL Users${NC}"
  /usr/bin/mysqladmin --user='root' --password='' password "${ROOT_PASSWORD}"
  
  if [ "${REMOTE_ROOT}" != "false" ]; then
    echo -e "${BLUE}### Create MySQL Remote Root User${NC}"
    /bin/echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${ROOT_PASSWORD}' WITH GRANT OPTION;" | /usr/bin/mysql --user='root' --password="${ROOT_PASSWORD}"
  fi

  echo -e "${BLUE}### Stop MySQL${NC}"
  /usr/bin/pkill mysqld
  i=0
  while [ $i -lt 10 ]
  do
    /usr/bin/mysqladmin --user='root' --password="${ROOT_PASSWORD}" ping>&/dev/null
    if [ $? -eq 0 ]; then
      sleep 5
      echo -e "${BLUE}## Waiting MySQL to stop...${NC}"
    else
      echo -e "${BLUE}## MySQL is Stopped!"
      break
    fi
    i=$[$i+1]
  done
fi

echo -e "${BLUE}### Delete environment file${NC}"
rm -f /run/env.sh
