source common.sh

##curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log


echo -e "\e[33m disable NodeJs \e[0m"
dnf module disable nodejs -y &>>/tmp/roboshop.log


echo -e "\e[33m enable nodeJs module \e[0m"
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m Install nodejs \e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log
VALIDATE $?


#echo -e "\e[33m remove application User \e[0m"
#id roboshop &>>/tmp/roboshop.log
#VALIDATE $?

echo -e "\e[33m Add application User \e[0m"
id roboshop &>>/tmp/roboshop.log
userdel roboshop &>>/tmp/roboshop.log
useradd roboshop &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m remove add directory \e[0m"
rm -rf /app
VALIDATE $?

echo -e "\e[33m add directory \e[0m"
mkdir /app &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m  Download the application code \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app &>> /tmp/roboshop.log &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m  Unzip  application code \e[0m"
unzip /tmp/catalogue.zip &>> /tmp/roboshop.log &>>/tmp/roboshop.log

VALIDATE $?

cd /app &>> /tmp/roboshop.log &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m Install npm\e[0m"
npm install &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m Setup SystemD Catalogue Service \e[0m"
cp /home/centos/d73/roboshop-shell1/catalogue.service  /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log
cp /home/centos/d73/roboshop-shell1/mongo.repo  /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m setup MongoDB repo  \e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
mongo --host mongodb-dev.adevlearn.shop </app/schema/catalogue.js &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m Load the service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m enable & Start the service \e[0m"
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log
VALIDATE $?