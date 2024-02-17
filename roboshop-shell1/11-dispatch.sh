source common.sh
component=dispatch

echo -e "${color} Install GoLang ${nocolor}"
yum install golang -y  &>>${log}
VALIDATE $?

echo -e "\e[33 mAdd application ${component} ${nocolor}"
useradd roboshop &>>${log}
VALIDATE $?

echo -e "${color} setup an app directory ${nocolor}"
mkdir /app &>>${log}
VALIDATE $?

echo -e "${color} Download Application code ${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
unzip /tmp/${component}.zip &>>${log}
VALIDATE $?

echo -e "${color} Download dependencies ${nocolor}"
cd /app &>>${log}
go mod init ${component} &>>${log}
go get &>>${log}
go build &>>${log}
VALIDATE $?

echo -e "${color} Setup SystemD ${component} Service ${nocolor}"
cp /home/centos/d73/roboshop-shell1/${component}.service  /etc/systemd/system/${component}.service &>>${log}
VALIDATE $?

echo -e "${color} Load the service ${nocolor}"
systemctl daemon-reload &>>${log}
VALIDATE $?

echo -e "${color} Enable & restart the service ${nocolor}"
systemctl enable ${component} &>>${log}
systemctl start ${component} &>>${log}
VALIDATE $?
