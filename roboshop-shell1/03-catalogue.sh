source common.sh
component=catalogue

nodejs

echo -e "${color} setup MongoDB repo  ${nocolor}"
dnf install mongodb-org-shell -y &>>${log}
VALIDATE $?

echo -e "${color} Load Master Data of the List of products ${nocolor}"
mongo --host mongodb-dev.adevlearn.shop </app/schema/${component}.js &>>${log}
VALIDATE $?

echo -e "${color} Load the service ${nocolor}"
systemctl daemon-reload &>>${log}
VALIDATE $?

echo -e "${color} enable & Start the service ${nocolor}"
systemctl enable ${component} &>>${log}
systemctl restart ${component} &>>${log}
VALIDATE $?