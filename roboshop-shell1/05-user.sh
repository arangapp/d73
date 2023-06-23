echo -e "\e[33mSetup NodeJS repos \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/roboshop.log
echo -e "\e[33m Install NodeJs \e[0m"
yum install nodejs -y &>> /tmp/roboshop.log

echo -e "\e[33mAdd Application User \e[0m"
useradd roboshop &>> /tmp/roboshop.log

echo -e "\e[33mremove App directory \e[0m"
rm -rf /app &>> /tmp/roboshop.log
echo -e "\e[33m Setup App directory \e[0m"
mkdir /app &>> /tmp/roboshop.log

echo -e "\e[33mDownload the application code to created app directory \e[0m"
cd /app
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>> /tmp/roboshop.log

echo -e "\e[33mExtract app content\e[0m"
unzip /tmp/user.zip &>> /tmp/roboshop.log
cd /app

echo -e "\e[33mdownload the dependencies and install npm \e[0m"
npm install &>> /tmp/roboshop.log
cd /app
echo -e "\e[33mSetup SystemD User Service \e[0m"
cp /home/centos/d73/roboshop-shell1/user.service  /etc/systemd/system/user.service &>> /tmp/roboshop.log

echo -e "\e[33Load the service\e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log

echo -e "\e[33Enable & Restart service\e[0m"
systemctl enable user &>> /tmp/roboshop.log
systemctl restart user  &>> /tmp/roboshop.log

echo -e "\e[33setup mongodb repo\e[0m"
cd /home/centos/d73/roboshop-shell1/mongo.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log

echo -e "\e[33Install mongodb\e[0m"
yum install mongodb-org-shell -y &>> /tmp/roboshop.log

echo -e "\e[33Load Schema\e[0m"
mongo --host mongodb-dev.adevlearn.shop </app/schema/user.js &>> /tmp/roboshop.log


