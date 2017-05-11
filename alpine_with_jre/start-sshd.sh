#!/bin/sh

echo "*****************************************"
echo  THE IP ADDRESS FOR THIS CONTAINER IS:
echo `ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'`
echo  THE CONTAINER ID IS:
echo  $HOSTNAME
echo "*****************************************"

/usr/sbin/sshd -D &
/bin/bash

