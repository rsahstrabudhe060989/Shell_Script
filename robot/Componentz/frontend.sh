#!/bin/bash

set -e # if any thing fail script will be exited

#validating  wheather the executed user is root or not

ID=$(id -u) 

if [ "$ID" -ne 0 ] ; then
   echo "you should execute this script as a root user"
   exit 1
fi

echo -n "Installing Ngnix :"

yum install nginx -y &>> /tmp/frontend.log
if [ $? -eq 0 ] ; then
echo -e "\e[32m success \e[0m"
else
echo "failure"
exit 2
fi

echo -n "Downloading the frontned Component:"

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
if [ $? -eq 0 ] ; then
echo -e "\e[32m success \e[0m"
else
echo "failure"
exit 2
fi

echo -n "Performing Cleanup of Old frontend:"
 cd /usr/share/nginx/html
 rm -rf * &>> /tmp/frontend.log
 
if [ $? -eq 0 ] ; then
echo -e "\e[32m success \e[0m"
else
echo "failure"
exit 2
fi

echo -n "Copying the downloaded frontend component:"
 unzip /tmp/frontend.zip &>>/tmp/frontend.log
 mv frontend-main/* .
 mv static/* .
 rm -rf frontend-main README.md
 mv localhost.conf /etc/nginx/default.d/roboshop.conf
if [ $? -eq 0 ] ; then
echo -e "\e[32m success \e[0m"
else
echo "failure"
exit 2
fi

echo -n "Starting the Server"
 systemctl enable nginx &>> /tmp/frontend.log
 systemctl start nginx &>> /tmp/frontend.log

