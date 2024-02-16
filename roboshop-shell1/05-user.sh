source common.sh
component=user

echo -e "\e[33m module disable nodejs \e[0m"
dnf module disable nodejs -y &>>${log}
VALIDATE $?

echo -e "\e[33m module enable nodejs \e[0m"
dnf module enable nodejs:18 -y &>>${log}
VALIDATE $?

echo -e "\e[33m Install NodeJs \e[0m"
dnf install nodejs -y &>>${log}
VALIDATE $?

echo -e "\e[33m add ${component} \e[0m"
id roboshop &>>${log}
userdel roboshop &>>${log}
useradd roboshop &>>${log}
VALIDATE $?

echo -e "\e[33m remove add directory \e[0m"
rm -rf /app &>>${log}
VALIDATE $?

echo -e "\e[33m add directory \e[0m"
mkdir /app &>>${log}
VALIDATE $?


echo -e "\e[33m  Download the application code \e[0m"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>>${log}
cd /app &>>${log}
unzip /tmp/${component}.zip &>>${log}
VALIDATE $?


echo -e "\e[33m Install npm\e[0m"
cd /app
npm install &>>${log}
VALIDATE $?

echo -e "\e[33m Setup SystemD ${component} Service \e[0m"
cp /home/centos/d73/roboshop-shell1/${component}.service  /etc/systemd/system/${component}.service &>>${log}
cp /home/centos/d73/roboshop-shell1/mongo.repo  /etc/yum.repos.d/mongo.repo &>>${log}
VALIDATE $?

cd /app
echo -e "\e[33m Setup SystemD ${component} Service \e[0m"
cp /home/centos/d73/roboshop-shell1/${component}.service  /etc/systemd/system/${component}.service &>>${log}
VALIDATE $?

echo -e "\e[33 Load the service\e[0m"
systemctl daemon-reload &>> ${log}
VALIDATE $?


echo -e "\e[33 setup mongodb repo\e[0m"
cd /home/centos/d73/roboshop-shell1/mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}

echo -e "\e[33 Install mongodb\e[0m"
yum install mongodb-org-shell -y &>>${log}
VALIDATE $?

echo -e "\e[33 Load Schema\e[0m"
mongo --host mongodb-dev.adevlearn.shop </app/schema/${component}.js &>>${log}
VALIDATE $?

echo -e "\e[33 Enable & Restart service \e[0m"
systemctl enable ${component} &>>${log}
systemctl restart ${component}  &>>${log}
VALIDATE $?
