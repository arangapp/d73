source common.sh
component=redis

echo -e "${color} Install rpm ${nocolor}"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${log}
status_check $?

echo -e "${color} Enable ${component} 6.2 ${nocolor}"
dnf module enable ${component}:remi-6.2 -y &>>${log}
status_check $?

echo -e "\e[33mInstall ${component}${nocolor}"
dnf install ${component} -y  &>>${log}
status_check $?

echo -e "${color} update listen address${nocolor}"
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/${component}.conf /etc/${component}/${component}.conf &>>${log}
status_check $?

echo -e "\e[33mEnable and restart ${component}${nocolor}"
systemctl enable ${component} &>>${log}
systemctl start ${component} &>>${log}
status_check $?