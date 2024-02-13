source common.sh

echo -e "\e[33m module disable nodejs \e[0m"
dnf module disable nodejs -y &>> /tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m module enable nodejs \e[0m"
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m Install NodeJs \e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m add user \e[0m"
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
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip  &>>/tmp/roboshop.log
cd /app
unzip /tmp/user.zip
VALIDATE $?


echo -e "\e[33m Install npm\e[0m"
cd /app
npm install &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m Setup SystemD Catalogue Service \e[0m"
cp /home/centos/d73/roboshop-shell1/user.service  /etc/systemd/system/user.service &>>/tmp/roboshop.log
cp /home/centos/d73/roboshop-shell1/mongo.repo  /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
VALIDATE $?

cd /app
echo -e "\e[33m Setup SystemD User Service \e[0m"
cp /home/centos/d73/roboshop-shell1/user.service  /etc/systemd/system/user.service &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33 Load the service\e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log
VALIDATE $?


echo -e "\e[33 setup mongodb repo\e[0m"
cd /home/centos/d73/roboshop-shell1/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33 Install mongodb\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33 Load Schema\e[0m"
mongo --host mongodb-dev.adevlearn.shop </app/schema/user.js &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33 Enable & Restart service \e[0m"
systemctl enable user &>>/tmp/roboshop.log
systemctl restart user  &>>/tmp/roboshop.log
VALIDATE $?
