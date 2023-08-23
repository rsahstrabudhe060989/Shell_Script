#!/bin/bash

set -e # if any thing fail script will be exited

#validating  wheather the executed user is root or not
component=mongodb
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

echo -n "Downloading the $component Component:"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "Installing the $component Component:"
yum install -y mongodb-org &>> $logfile
stat $?
systemctl enable mongod
systemctl start mongod
