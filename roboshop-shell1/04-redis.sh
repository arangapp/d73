source common.sh
component=redis

echo -e "\e[33m Install rpm \e[0m"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${log}
VALIDATE $?

echo -e "\e[33m Enable ${component} 6.2 \e[0m"
dnf module enable ${component}:remi-6.2 -y &>>${log}
VALIDATE $?

echo -e "\e[33mInstall ${component}\e[0m"
dnf install ${component} -y  &>>${log}
VALIDATE $?

echo -e "\e[33m update listen address\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/${component}.conf /etc/${component}/${component}.conf &>>${log}
VALIDATE $?

echo -e "\e[33mEnable and restart ${component}\e[0m"
systemctl enable ${component} &>>${log}
systemctl start ${component} &>>${log}
VALIDATE $?