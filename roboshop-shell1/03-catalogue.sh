source common.sh
component=catalogue

nodejs

echo -e "${color} Setup SystemD ${component} Service ${nocolor}"
cp /home/centos/d73/roboshop-shell1/${component}.service  /etc/systemd/system/${component}.service &>>${log}
cp /home/centos/d73/roboshop-shell1/mongo.repo  /etc/yum.repos.d/mongo.repo &>>${log}
status_check $?

echo -e "${color} Load the service ${nocolor}"
systemctl daemon-reload &>>${log}
status_check $?

echo -e "${color} enable & Start the service ${nocolor}"
systemctl enable ${component} &>>${log}
systemctl restart ${component} &>>${log}
status_check $?

echo -e "${color} setup MongoDB repo  ${nocolor}"
dnf install mongodb-org-shell -y &>>${log}
status_check $?

echo -e "${color} Load Master Data of the List of products ${nocolor}"
mongo --host mongodb-dev.adevlearn.shop </app/schema/${component}.js &>>${log}
status_check $?

