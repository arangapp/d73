echo -e "\e[33m Install GoLang \e[0m"
yum install golang -y  &>> /tmp/roboshop.log

echo -e "\e[33 mAdd application user \e[0m"
useradd roboshop &>> /tmp/roboshop.log

echo -e "\e[33m setup an app directory \e[0m"
mkdir /app &>> /tmp/roboshop.log

echo -e "\e[33m Download Application code \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>> /tmp/roboshop.log
cd /app
unzip /tmp/dispatch.zip

echo -e "\e[33m Download dependencies \e[0m"
cd /app
go mod init dispatch &>> /tmp/roboshop.log
go get
go build

echo -e "\e[33m Setup SystemD Payment Service \e[0m"
cp /home/centos/d73/roboshop-shell1/dispatch.service  /etc/systemd/system/dispatch.service &>> /tmp/roboshop.log

echo -e "\e[33m Load the service \e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log

echo -e "\e[33m Enable & restart the service \e[0m"
systemctl enable dispatch &>> /tmp/roboshop.log
systemctl start dispatch &>> /tmp/roboshop.log


