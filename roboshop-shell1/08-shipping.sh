source common.sh

echo -e "\e[33m Install Maven \e[0m"
dnf install maven -y &>>/tmp/roboshop.log
VALIDATE $?

echo -e "\e[33m Add Application User \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m setup an app directory \e[0m"
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m  Download the application code \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[33m download the dependencies & build the application \e[0m"
cd /app
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e "\e[33m setup SystemD Shipping Service \e[0m"
cp /home/centos/d73/roboshop-shell1/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log



echo -e "\e[33m Install Mysql client \e[0m"
dnf install mysql -y  &>>/tmp/roboshop.log

echo -e "\e[33m  Load the service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[33m Load Schema \e[0m"
mysql -h mysql-dev.adevlearn.shop -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[33m enable & restart Server \e[0m"
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log

