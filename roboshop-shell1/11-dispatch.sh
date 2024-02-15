source common.sh
log="/tmp/roboshop.log"

echo -e "\e[33m Install GoLang \e[0m"
yum install golang -y  &>>${log}
VALIDATE $?

echo -e "\e[33 mAdd application user \e[0m"
useradd roboshop &>>${log}
VALIDATE $?

echo -e "\e[33m setup an app directory \e[0m"
mkdir /app &>>${log}
VALIDATE $?

echo -e "\e[33m Download Application code \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>${log}
unzip /tmp/dispatch.zip &>>${log}
VALIDATE $?

echo -e "\e[33m Download dependencies \e[0m"
cd /app &>>${log}
go mod init dispatch &>>${log}
go get &>>${log}
go build &>>${log}
VALIDATE $?

echo -e "\e[33m Setup SystemD Payment Service \e[0m"
cp /home/centos/d73/roboshop-shell1/dispatch.service  /etc/systemd/system/dispatch.service &>>${log}
VALIDATE $?

echo -e "\e[33m Load the service \e[0m"
systemctl daemon-reload &>>${log}
VALIDATE $?

echo -e "\e[33m Enable & restart the service \e[0m"
systemctl enable dispatch &>>${log}
systemctl start dispatch &>>${log}
VALIDATE $?
