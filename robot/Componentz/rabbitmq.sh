#!/bin/bash

set -e # if any thing fail script will be exited

#validating  wheather the executed user is root or not
component=rabbitmq


source Componentz/common.sh 

 echo -n "Installation ERLang Dependency:"
 curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>> $logfile
 curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>> $logfile
 $?
echo -n "Installation $component:"
yum install rabbitmq-server -y
 $?

 systemctl enable rabbitmq-server 
 systemctl start rabbitmq-server

echo -n "Creating $component aaplication"

rabbitmqctl list_users | grep roboshop &>> $logfile
if [ $? -ne 0]; then
 rabbitmqctl add_user roboshop roboshop123
 rabbitmqctl set_user_tags roboshop administrator
 rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
```stat $?
fi
