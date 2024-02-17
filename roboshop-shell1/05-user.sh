source common.sh
component=user

echo -e "${color} module disable nodejs ${nocolor}"
dnf module disable nodejs -y &>>${log}
VALIDATE $?

echo -e "${color} module enable nodejs ${nocolor}"
dnf module enable nodejs:18 -y &>>${log}
VALIDATE $?

echo -e "${color} Install NodeJs ${nocolor}"
dnf install nodejs -y &>>${log}
VALIDATE $?

echo -e "${color} add ${component} ${nocolor}"
id roboshop &>>${log}
userdel roboshop &>>${log}
useradd roboshop &>>${log}
VALIDATE $?

echo -e "${color} remove add directory ${nocolor}"
rm -rf /app &>>${log}
VALIDATE $?

echo -e "${color} add directory ${nocolor}"
mkdir /app &>>${log}
VALIDATE $?


echo -e "${color}  Download the application code ${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>>${log}
cd /app &>>${log}
unzip /tmp/${component}.zip &>>${log}
VALIDATE $?


echo -e "${color} Install npm${nocolor}"
cd /app
npm install &>>${log}
VALIDATE $?

echo -e "${color} Setup SystemD ${component} Service ${nocolor}"
cp /home/centos/d73/roboshop-shell1/${component}.service  /etc/systemd/system/${component}.service &>>${log}
cp /home/centos/d73/roboshop-shell1/mongo.repo  /etc/yum.repos.d/mongo.repo &>>${log}
VALIDATE $?

echo -e "\e[33 Load the service ${nocolor}"
systemctl daemon-reload &>> ${log}
VALIDATE $?

echo -e "\e[33 setup mongodb repo ${nocolor}"
cd /home/centos/d73/roboshop-shell1/mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}

echo -e "\e[33 Install mongodb ${nocolor}"
yum install mongodb-org-shell -y &>>${log}
VALIDATE $?

echo -e "\e[33 Load Schema ${nocolor}"
mongo --host mongodb-dev.adevlearn.shop </app/schema/${component}.js &>>${log}
VALIDATE $?

echo -e "\e[33 Enable & Restart service ${nocolor}"
systemctl enable ${component} &>>${log}
systemctl restart ${component} &>>${log}
VALIDATE $?
