source common.sh
component=rabbitmq

echo -e "${color} configure yum repos ${nocolor}"
curl -s https://packagecloud.io/install/repositories/${component}/erlang/script.rpm.sh | bash &>>${log}
VALIDATE $?

echo -e "${color} Configure YUM Repos for ${component} ${nocolor}"
curl -s https://packagecloud.io/install/repositories/${component}/${component}-server/script.rpm.sh | bash &>>${log}
VALIDATE $?

echo -e "${color} Install ${component} ${nocolor}"
dnf install ${component}-server -y &>>${log}
VALIDATE $?

echo -e "${color} enable & start ${component} ${nocolor}"
systemctl enable ${component}-server  &>>${log}
systemctl restart ${component}-server  &>>${log}
VALIDATE $?

echo -e "${color} create a ${component} for the application ${nocolor}"
rabbitmqctl add_user roboshop roboshop123 &>>${log}
VALIDATE $?
echo -e "${color} set permission to ${component} for the application ${nocolor}"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log}
VALIDATE $?

