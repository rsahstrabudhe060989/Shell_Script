#!/bin/bash

set -e # if any thing fail script will be exited

#validating  wheather the executed user is root or not
component=user
logfile="/tmp/$component.log"
appuser=roboshop

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
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> $logfile
stat $?

echo -n "Installation of $component Component:"
yum install nodejs -y  &>> $logfile
stat $?

id $appuser  &>> $logfile
if [ $? -ne 0 ]; then
     echo -n " Creating  The application User Accounts:" &>> $logfile
    useradd roboshop  &>> $logfile
     stat $?
   fi


echo -n " Downloading the $component component:"
curl -s -L -o /tmp/$component.zip "https://github.com/stans-robot-project/$component/archive/main.zip"  &>> $logfile
stat $?

echo -n "Extracting the $component"
cd /home/roboshop/
rm -rf /home/roboshop/$component 
unzip -o /tmp/$component.zip &>> $logfile
stat $?

echo -n "Configurng the permissions:"
mv /home/roboshop/$component-main/ /home/roboshop/$component
chown -R roboshop:roboshop /home/roboshop/$component  &>> $logfile
stat $?

echo -n "Installing the $component Application:"
cd /home/roboshop/$component/
npm install &>> $logfile
stat $?


echo -n "Updating the systemD file with DB Details:"
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' /home/roboshop/$component/systemd.service &>> $logfile
sed -i -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/roboshop/$component/systemd.service &>> $logfile
mv /home/roboshop/$component/systemd.service /etc/systemd/system/$component.service &>> $logfile
stat $?

echo -n "starting service:"
 systemctl daemon-reload &>> $logfile
 systemctl enable $component &>> $logfile
 systemctl restart $component &>> $logfile
 stat $?