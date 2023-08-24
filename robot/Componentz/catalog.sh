#!/bin/bash

set -e # if any thing fail script will be exited

#validating  wheather the executed user is root or not
component=catalog
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
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> $logfile
stat $?

echo -n "Installation of $component Component:"
yum install nodejs -y &>> $logfile
stat $?

echo -n " Creating  The application User Accounts:"
useradd roboshop &>> $logfile
stat $?

echo -n " Downloading the $component component:"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip" &>> $logfile
echo -n "Extracting the $component"
cd /home/roboshop
unzip -o /tmp/catalogue.zip &>> $logfile
