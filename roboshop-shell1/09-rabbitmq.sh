source common.sh
component=rabbitmq

echo -e "\e[33m configure yum repos \e[0m"
curl -s https://packagecloud.io/install/repositories/${component}/erlang/script.rpm.sh | bash &>>${log}
VALIDATE $?

echo -e "\e[33m Configure YUM Repos for ${component} \e[0m"
curl -s https://packagecloud.io/install/repositories/${component}/${component}-server/script.rpm.sh | bash &>>${log}
VALIDATE $?

echo -e "\e[33m Install ${component} \e[0m"
dnf install ${component}-server -y &>>${log}
VALIDATE $?

echo -e "\e[33m enable & start ${component} \e[0m"
systemctl enable ${component}-server  &>>${log}
systemctl restart ${component}-server  &>>${log}
VALIDATE $?

echo -e "\e[33m create a ${component} for the application \e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>${log}
VALIDATE $?
echo -e "\e[33m set permission to ${component} for the application \e[0m"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log}
VALIDATE $?

