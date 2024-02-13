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
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip  &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
unzip /tmp/cart.zip &>>/tmp/roboshop.log
VALIDATE $?


echo -e "\e[33m Install npm\e[0m"
cd /app
npm install &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m Setup SystemD Catalogue Service \e[0m"
cp /home/centos/d73/roboshop-shell1/cart.service  /etc/systemd/system/cart.service &>>/tmp/roboshop.log
cp /home/centos/d73/roboshop-shell1/mongo.repo  /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
VALIDATE $?

cd /app
echo -e "\e[33m Setup SystemD User Service \e[0m"
cp /home/centos/d73/roboshop-shell1/cart.service  /etc/systemd/system/cart.service &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33 Load the service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33 Enable and restart service\e[0m"
systemctl enable cart &>>/tmp/roboshop.log
systemctl start cart  &>>/tmp/roboshop.log