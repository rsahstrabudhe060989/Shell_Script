#!/bin/bash

set -r # if any thing fail script will be exited

#validating  wheather the executed user is root or not
user_id=${id -u} 
if [ "$user_id" -ne 0] ; then
   echo "you should execute this script as a root user"
   exit 1
fi
yum install nginx -y &>> /tmp/frontend.log

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

 cd /usr/share/nginx/html
 rm -rf * &>> /tmp/frontend.log
 unzip /tmp/frontend.zip
 mv frontend-main/* .
 mv static/* .
 rm -rf frontend-main README.md
 mv localhost.conf /etc/nginx/default.d/roboshop.conf
 systemctl enable nginx &>> /tmp/frontend.log
 systemctl start nginx &>> /tmp/frontend.log

