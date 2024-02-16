source common.sh
component=dispatch

echo -e "\e[33m Install GoLang \e[0m"
yum install golang -y  &>>${log}
VALIDATE $?

echo -e "\e[33 mAdd application ${component} \e[0m"
useradd roboshop &>>${log}
VALIDATE $?

echo -e "\e[33m setup an app directory \e[0m"
mkdir /app &>>${log}
VALIDATE $?

echo -e "\e[33m Download Application code \e[0m"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
unzip /tmp/${component}.zip &>>${log}
VALIDATE $?

echo -e "\e[33m Download dependencies \e[0m"
cd /app &>>${log}
go mod init ${component} &>>${log}
go get &>>${log}
go build &>>${log}
VALIDATE $?

echo -e "\e[33m Setup SystemD ${component} Service \e[0m"
cp /home/centos/d73/roboshop-shell1/${component}.service  /etc/systemd/system/${component}.service &>>${log}
VALIDATE $?

echo -e "\e[33m Load the service \e[0m"
systemctl daemon-reload &>>${log}
VALIDATE $?

echo -e "\e[33m Enable & restart the service \e[0m"
systemctl enable ${component} &>>${log}
systemctl start ${component} &>>${log}
VALIDATE $?
