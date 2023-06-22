echo -e "\e[33m setup NodeJs repos \e[0m]"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/roboshop.log

echo -e "\e[33mInstall NodeJs \e[0m]"
yum install nodejs -y &>> /tmp/roboshop.log

echo -e "\e[33 mAdd Application user \e[0m]"
useradd roboshop &>> /tmp/roboshop.log


echo -e "\e[33m Setup  App directory \e[0m]"
mkdir /app &>> /tmp/roboshop.log

echo -e "\e[33m Download the application code \e[0m]"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>> /tmp/roboshop.log
cd /app &>> /tmp/roboshop.log
unzip /tmp/cart.zip &>> /tmp/roboshop.log

echo -e "\e[33m download the dependencies and install rpm \e[0m]"
cd /app &>> /tmp/roboshop.log
npm install &>> /tmp/roboshop.log

echo -e "\e[33m Setup SystemD Cart Service \e[0m]"
cp cp /home/centos/d73/roboshop-shell1/user.service /etc/systemd/system/cart.service &>> /tmp/roboshop.log

echo -e "\e[33m Load the service \e[0m]"
systemctl daemon-reload &>> /tmp/roboshop.log

echo -e "\e[33m enable and restart server \e[0m]"
systemctl enable cart &>> /tmp/roboshop.log
systemctl restart cart &>> /tmp/roboshop.log