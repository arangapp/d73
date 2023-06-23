echo -e "\e[33mSetup NodeJS repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/roboshop.log

echo -e "\e[33m Install Node Js\e[0m"
yum install nodejs -y &>> /tmp/roboshop.log
echo -e "\e[33m add app user\e[0m"
useradd roboshop &>> /tmp/roboshop.log

echo -e "\e[33m setup an app directory\e[0m"
mkdir /app &>> /tmp/roboshop.log

echo -e "\e[33m Download the application code to created app directory\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>> /tmp/roboshop.log
cd /app
echo -e "\e[33m Extract code \e[0m"
unzip /tmp/catalogue.zip &>> /tmp/roboshop.log
cd /app

echo -e "\e[33m Install npm\e[0m"
npm install &>> /tmp/roboshop.log

echo -e "\e[33m Setup SystemD Catalogue Service\e[0m"
cp /home/centos/d73/roboshop-shell1/catalogue.service /etc/systemd/system/catalogue.service &>> /tmp/roboshop.log

echo -e "\e[33m Load the service\e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log

echo -e "\e[33m Enable & Restart server\e[0m"
systemctl enable catalogue &>> /tmp/roboshop.log
systemctl restart catalogue &>> /tmp/roboshop.log

echo -e "\e[33m setup MongoDB repo\e[0m"
cd mongo.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log

echo -e "\e[33m Install mongodb-client\e[0m"
yum install mongodb-org-shell -y &>> /tmp/roboshop.log

echo -e "\e[33m Load Schema\e[0m"
mongo --host mongodb-dev.adevlearn.shop </app/schema/catalogue.js &>> /tmp/roboshop.log



