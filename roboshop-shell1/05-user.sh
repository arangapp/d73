echo -e "\e[33m Setup NodeJS repos \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/roboshop.log
echo -e "\e[33m Install NodeJs \e[0m"
yum install nodejs -y &>> /tmp/roboshop.log &>> /tmp/roboshop.log
echo -e "\e[33m Add Application User \e[0m"
useradd roboshop &>> /tmp/roboshop.log &>> /tmp/roboshop.log
echo -e "\e[33m Setup App directory \e[0m"
mkdir /app &>> /tmp/roboshop.log
echo -e "\e[33m Download the application code to created app directory \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>> /tmp/roboshop.log
cd /app &>> /tmp/roboshop.log
unzip /tmp/user.zip &>> /tmp/roboshop.log

echo -e "\e[33m download the dependencies and install npm \e[0m"
cd /app &>> /tmp/roboshop.log
npm install &>> /tmp/roboshop.log
echo -e "\e[33m Setup SystemD User Service \e[0m"
cp /home/centos/d73/roboshop-shell1/user.service  /etc/systemd/system/user.service &>> /tmp/roboshop.log

echo -e "\e[33 Load the service\e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log

echo -e "\e[33 Enable & Restart service\e[0m"
systemctl enable user &>> /tmp/roboshop.log
systemctl start user  &>> /tmp/roboshop.log

echo -e "\e[33 setup MongoDB repo\e[0m"
cd mongo.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log
echo -e "\e[33 Install mongodb\e[0m"
yum install mongodb-org-shell -y &>> /tmp/roboshop.log
echo -e "\e[33 Load Schema\e[0m"
mongo --host mongodb-dev.adevlearn.shop </app/schema/user.js &>> /tmp/roboshop.log
