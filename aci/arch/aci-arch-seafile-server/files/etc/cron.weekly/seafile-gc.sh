#!/bin/bash

#####
# Uncomment the following line if you rather want to run the script manually.
# Display usage if the script is not run as root user
#        if [[ $USER != "root" ]]; then
#                echo "This script must be run as root user!"
#                exit 1
#        fi
#
# echo "Super User detected!!"
# read -p "Press [ENTER] to start the procedure, this will stop the seafile server!!"
#####

# stop the server
echo Stopping the Seafile-Server...
/seafile/seafile-server-latest/seafile-server stop

echo Giving the server some time to shut down properly....
sleep 10

# run the cleanup
echo Seafile cleanup started...
sudo -u seafile /seafile/seafile-server-latest/seaf-gc.sh -r

echo Giving the server some time....
sleep 3

# start the server again
echo Starting the Seafile-Server...
/seafile/seafile-server-latest/seafile-server start

echo Seafile cleanup done!