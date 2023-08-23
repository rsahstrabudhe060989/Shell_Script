#!/bin/bash

set -e # if any thing fail script will be exited

#validating  wheather the executed user is root or not
component=frontend
logfile= "/tmp/$component.log"

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

echo -n "Installing Ngnix :"
yum install nginx -y &>> $logfile
stat $?

echo -n "Downloading the $component Component:"
curl -s -L -o /tmp/$component.zip "https://github.com/stans-robot-project/$component/archive/main.zip"
stat $?

echo -n "Performing Cleanup of Old $component:"
cd /usr/share/nginx/html
rm -rf * &>> $logfile
stat $?

echo -n "Copying the downloaded $component component:"
unzip /tmp/$component.zip &>> $logfile
mv $component-main/* .
mv static/* .
rm -rf $component-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Starting the Server"
systemctl enable nginx &>> $logfile
systemctl start nginx &>> $logfile

