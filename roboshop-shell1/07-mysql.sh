source common.sh
component=mysql

echo -e "${color} disable ${component} 8 version ${nocolor}"
dnf module disable ${component} -y  &>>${log}
status_check $?

echo -e "${color} check the directory exits ${nocolor}"
ls -ld /etc/yum.repos.d/ &>>${log}
status_check $?

echo -e "${color} create a directory ${nocolor}"
sudo mkdir -p /etc/yum.repos.d/
status_check $?

echo -e "${color} Setup the MySQL5.7 repo file ${nocolor}"
cp /home/centos/d73/roboshop-shell1/${component}.repo /etc/yum.repos.d/${component}.repo  &>>${log}
status_check $?

echo -e "${color} Install ${component} Server ${nocolor}"
dnf install ${component}-community-server -y &>>${log}
status_check $?

echo -e "${color} enable & restart MqSql ${nocolor}"
systemctl enable mysqld &>>${log}
systemctl restart mysqld &>>${log}
status_check $?

echo -e "${color} change the default root password ${nocolor}"
mysql_secure_installation --set-root-pass RoboShop@1 &>>${log}
status_check $?

echo -e "${color} check the new password working or not ${nocolor}"
${component} -uroot -pRoboShop@1 &>>${log}
status_check $?