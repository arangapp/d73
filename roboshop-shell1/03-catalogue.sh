curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
yum install nodejs -y &>>/tmp/roboshop.log
useradd roboshop &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app &>> /tmp/roboshop.log &>>/tmp/roboshop.log
unzip /tmp/catalogue.zip &>> /tmp/roboshop.log &>>/tmp/roboshop.log
cd /app &>> /tmp/roboshop.log &>>/tmp/roboshop.log
npm install &>> /tmp/roboshop.log &>>/tmp/roboshop.log
cp cp /home/centos/d73/roboshop-shell1/catalogue.service   /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log
cp /home/centos/d73/roboshop-shell1/mongo.repo  /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
mongo --host mongodb-dev.adevlearn.shop </app/schema/catalogue.js &>>/tmp/roboshop.log

systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log