#!/bin/bash

set -e # if any thing fail script will be exited

#validating  wheather the executed user is root or not
component=redis
logfile="/tmp/$component.log"

ID=$(id -u) 

if [ "$ID" -ne 0 ] ; then
   echo "you should execute this script as a root user"
   exit 1
fi

stat() {

   if [ $1 -eq 0 ] ; then
      echo -e "\e[32m success \e[0m"
   else
      echo -e "\e[31m  Failure \e[0m"
   exit 2
fi
}
echo -n "Configuring $component repo:"
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>> $logfile
stat $?

echo -n "Installing $component server"
yum install redis-6.2.11 -y  &>> $logfile
stat $?

echo -n "Updating the $component visibility"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
stat $?

echo -n "performing $component Daemon-Reload :"
systemctl daemon-reload &>> $logfile
systemctl restart $component  &>> $logfile
stat $?