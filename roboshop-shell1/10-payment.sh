source common.sh
component=paymentn

echo -e "\e[33m Install python3.6 \e[0m"
dnf install python36 gcc python3-devel -y &>>${log}
VALIDATE $?

echo -e "\e[33m add application ${component} \e[0m"
id roboshop &>>${log}
userdel -r roboshop &>>${log}
useradd roboshop &>>${log}
VALIDATE $?

echo -e "\e[33m remove add directory \e[0m"
rm -rf /app &>>${log}
VALIDATE $?

echo -e "\e[33m Set an app directory \e[0m"
mkdir /app &>>${log}
VALIDATE $?

echo -e "\e[33m Download the Application code \e[0m"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
cd /app &>>${log}
unzip /tmp/${component}.zip &>>${log}
VALIDATE $?

echo -e "\e[33m Download dependencies \e[0m"
cd /app &>>${log}
pip3.6 install -r requirements.txt &>>${log}
VALIDATE $?

echo -e "\e[33mSetup SystemD ${component} Service \e[0m"
cp /home/centos/d73/roboshop-shell1/${component}.service  /etc/systemd/system/${component}.service &>>${log}
VALIDATE $?

echo -e "\e[33m Load the service \e[0m"
systemctl daemon-reload &>>${log}
VALIDATE $?

echo -e "\e[33m Enable & restart service \e[0m"
systemctl enable ${component} &>>${log}
systemctl restart ${component} &>>${log}
VALIDATE $?
