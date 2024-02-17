source common.sh
component=dispatch

echo -e "${color} Install GoLang ${nocolor}"
yum install golang -y  &>>${log}
status_check $?

echo -e "${color} Add application ${component} ${nocolor}"
id roboshop &>>${log}
userdel roboshop &>>${log}
useradd roboshop &>>${log}
status_check $?

echo -e "${color} remove add directory ${nocolor}"
rm -rf /app
status_check $?

echo -e "${color} add directory ${nocolor}"
mkdir /app &>>${log}
status_check $?

echo -e "${color} Download Application code ${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
unzip /tmp/${component}.zip &>>${log}
status_check $?

echo -e "${color} Download dependencies ${nocolor}"
cd /app &>>${log}
go mod init ${component} &>>${log}
go get &>>${log}
go build &>>${log}
status_check $?

echo -e "${color} Setup SystemD ${component} Service ${nocolor}"
cp /home/centos/d73/roboshop-shell1/${component}.service  /etc/systemd/system/${component}.service &>>${log}
status_check $?

echo -e "${color} Load the service ${nocolor}"
systemctl daemon-reload &>>${log}
status_check $?

echo -e "${color} Enable & restart the service ${nocolor}"
systemctl enable ${component} &>>${log}
systemctl start ${component} &>>${log}
status_check $?
