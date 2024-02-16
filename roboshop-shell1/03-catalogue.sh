source common.sh
component=catalogue

nodejs

echo -e "\e[33m setup MongoDB repo  \e[0m"
yum install mongodb-org-shell -y &>>${log}
mongo --host mongodb-dev.adevlearn.shop </app/schema/${component}.js &>>${log}
VALIDATE $?

echo -e "\e[33m Load the service \e[0m"
systemctl daemon-reload &>>${log}
VALIDATE $?

echo -e "\e[33m enable & Start the service \e[0m"
systemctl enable ${component} &>>${log}
systemctl restart ${component} &>>${log}
VALIDATE $?