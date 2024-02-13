source common.sh

dnf module disable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y

useradd roboshop
mkdir /app

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

cd /app
npm install

mongo --host mongodb-dev.adevlearn.shop </app/schema/catalogue.js

systemctl daemon-reload

systemctl enable catalogue
systemctl start catalogue