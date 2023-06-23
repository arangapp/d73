echo -e "\e[33mSetup NodeJS repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/roboshop.log

echo -e "\e[33mInstall Node Js\e[0m"
yum install nodejs -y &>> /tmp/roboshop.log
echo -e "\e[33madd app user\e[0m"
useradd roboshop &>> /tmp/roboshop.log

echo -e "\e[33msetup an app directory\e[0m"
mkdir /app &>> /tmp/roboshop.log
echo -e "\e[33mDownload the application code to created app directory\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>> /tmp/roboshop.log
cd /app
unzip /tmp/catalogue.zip &>> /tmp/roboshop.log

echo -e "\e[33mdownload the dependencies\e[0m"
cd /app &>> /tmp/roboshop.log
echo -e "\e[33mInstall npm\e[0m"
npm install &>> /tmp/roboshop.log

echo -e "\e[33mSetup SystemD Catalogue Service\e[0m"
cp /home/centos/d73/roboshop-shell1/catalogue.service /etc/systemd/system/catalogue.service &>> /tmp/roboshop.log
echo -e "\e[33mLoad the service\e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log

echo -e "\e[33msetup MongoDB repo\e[0m"
cd mongo.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log

echo -e "\e[33mInstall mongodb-client\e[0m"
yum install mongodb-org-shell -y &>> /tmp/roboshop.log

echo -e "\e[33mLoad Schema\e[0m"
mongo --host mongodb-dev.adevlearn.shop </app/schema/catalogue.js &>> /tmp/roboshop.log

echo -e "\e[33m Enable & Restart server\e[0m"
systemctl enable catalogue &>> /tmp/roboshop.log
systemctl restart catalogue &>> /tmp/roboshop.log

