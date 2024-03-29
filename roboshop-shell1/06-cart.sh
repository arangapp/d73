source common.sh
component=cart
nodejs

echo -e "${color} Setup SystemD ${component} Service ${nocolor}"
cp /home/centos/d73/roboshop-shell1/${component}.service  /etc/systemd/system/${component}.service &>>${log}
status_check $?

echo -e "${color} Load the service ${nocolor}"
systemctl daemon-reload &>>${log}
status_check $?

echo -e "${color} Enable and restart service ${nocolor}"
systemctl enable ${component} &>>${log}
systemctl start ${component}  &>>${log}
status_check $?