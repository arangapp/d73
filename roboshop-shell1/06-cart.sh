source common.sh
component=cart

nodejs

cd /app
echo -e "\e[33m Setup SystemD ${component} Service \e[0m"
cp /home/centos/d73/roboshop-shell1/${component}.service  /etc/systemd/system/${component}.service &>>${log}
VALIDATE $?

echo -e "\e[33 Load the service \e[0m"
systemctl daemon-reload &>>${log}
VALIDATE $?

echo -e "\e[33 Enable and restart service \e[0m"
systemctl enable ${component} &>>${log}
systemctl start ${component}  &>>${log}
VALIDATE $?