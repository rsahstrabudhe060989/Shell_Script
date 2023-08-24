#!/bin/bash

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

CREATE_USER(){
id $appuser  &>> $logfile
if [ $? -ne 0 ]; then
     echo -n " Creating  The application User Accounts:" &>> $logfile
    useradd roboshop  &>> $logfile
     stat $?
fi
}

DOWNLOAD_AND_EXTRACT()
{
echo -n " Downloading the $component component:"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"  &>> $logfile
stat $?

echo -n "Extracting the $component"
cd /home/roboshop/
rm -rf /home/roboshop/$component &>> $logfile
unzip -o /tmp/$component.zip  &>> $logfile
stat $?

echo -n "Configurng the permissions:"
mv /home/roboshop/$component-main/ /home/roboshop/$component
chown -R roboshop:roboshop /home/roboshop/$component &>> $logfile
stat $?
}

NPM_INSTALL()
{

echo -n "Installing the $component Application:"
cd /home/roboshop/$component/
npm install &>> $logfile
stat $?

}
CONFIG_SVC(){
echo -n "Updating the systemD file with DB Details:"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/$component/systemd.service
stat $?
echo -n "Updating the systemD file with DB Details:"
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' /home/roboshop/$component/systemd.service &>> $logfile
sed -i -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/roboshop/$component/systemd.service &>> $logfile
stat $?
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' /home/roboshop/$component/systemd.service  &>> $logfile
sed -i -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' /home/roboshop/$component/systemd.service  &>> $logfile
sed -i -e 's/CARTENDPOINT /cart.roboshop.internal/' /home/roboshop/$component/systemd.service  &>> $logfile
sed -i -e 's/DBHOST/mysql.roboshop.internal/' /home/roboshop/$component/systemd.service  &>> $logfile

mv /home/roboshop/$component/systemd.service /etc/systemd/system/$component.service  &>> $logfile

stat $?

 echo -n "starting service:"
 systemctl daemon-reload &>> $logfile
 systemctl enable $component &>> $logfile
 systemctl restart $component &>> $logfile

}
NODEJS()

{
echo -n "Downloading the $component Component:"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> $logfile
stat $?

echo -n "Installation of $component Component:"
yum install nodejs -y  &>> $logfile
stat $?

# Calling CreateUser Function
CREATE_USER

#Calling Download_and_Extract
DOWNLOAD_AND_EXTRACT

#Calling NPM Istall Function
NPM_INSTALL

#Calling Config svc function
CONFIG_SVC
}
MVN_PACKAGE(){
echo -n "Starting the $Component service :"
cd /home/$APPUSER/$component/
mvn clean package &>> $logfile
}

JAVA(){

echo  -n "Insttalling Maven:"
yum install maven -y    &>> $logfile ( installs maven with java 8 )
stat $?
CREATE_USER
DOWNLOAD_AND_EXTRACT
mv target/shipping-1.0.jar shipping.jar
stat $?
MVN_PACKAGE
}