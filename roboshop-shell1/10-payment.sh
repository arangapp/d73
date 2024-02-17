source common.sh
component=payment

echo -e "${color} Install python3.6 ${nocolor}"
dnf install python36 gcc python3-devel -y &>>${log}
VALIDATE $?

echo -e "${color} add application ${component} ${nocolor}"
id roboshop &>>${log}
userdel -r roboshop &>>${log}
useradd roboshop &>>${log}
VALIDATE $?

echo -e "${color} remove add directory ${nocolor}"
rm -rf /app &>>${log}
VALIDATE $?

echo -e "${color} Set an app directory ${nocolor}"
mkdir /app &>>${log}
VALIDATE $?

echo -e "${color} Download the Application code ${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
cd /app &>>${log}
unzip /tmp/${component}.zip &>>${log}
VALIDATE $?

echo -e "${color} Download dependencies ${nocolor}"
cd /app &>>${log}
pip3.6 install -r requirements.txt &>>${log}
VALIDATE $?

echo -e "\e[33mSetup SystemD ${component} Service ${nocolor}"
cp /home/centos/d73/roboshop-shell1/${component}.service  /etc/systemd/system/${component}.service &>>${log}
VALIDATE $?

echo -e "${color} Load the service ${nocolor}"
systemctl daemon-reload &>>${log}
VALIDATE $?

echo -e "${color} Enable & restart service ${nocolor}"
systemctl enable ${component} &>>${log}
systemctl restart ${component} &>>${log}
VALIDATE $?
