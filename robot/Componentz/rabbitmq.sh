#!/bin/bash

set -e # if any thing fail script will be exited

#validating  wheather the executed user is root or not
component=rabbitmq


source Componentz/common.sh 

 echo -n "Installation ERLang Dependency:"
 curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash  
 curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash 
 stat $?
echo -n "Installation $component:"
yum install rabbitmq-server -y
  stat $?

 systemctl enable rabbitmq-server 
 systemctl start rabbitmq-server

echo -n "Creating $component aaplication"

rabbitmqctl list_users | grep roboshop 
if [ $? -ne 0]; then
 echo -n " Creating  The application User Accounts:" 
 rabbitmqctl add_user roboshop roboshop123
 stat $?
fi
 rabbitmqctl set_user_tags roboshop administrator
 rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
stat $?

