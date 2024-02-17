source common.sh
component=mysql

echo -e "${color} disable ${component} 8 version ${nocolor}"
dnf module disable ${component} -y  &>>${log}
VALIDATE $?

echo -e "${color} check the directory exits ${nocolor}"
ls -ld /etc/yum.repos.d/ &>>${log}
VALIDATE $?

echo -e "${color} create a directory ${nocolor}"
sudo mkdir -p /etc/yum.repos.d/
VALIDATE $?

echo -e "${color} Setup the MySQL5.7 repo file ${nocolor}"
cp /home/centos/d73/roboshop-shell1/${component}.repo /etc/yum.repos.d/${component}.repo  &>>${log}
VALIDATE $?

echo -e "${color} Install ${component} Server ${nocolor}"
dnf install ${component}-community-server -y &>>${log}
VALIDATE $?

echo -e "${color} enable & restart MqSql ${nocolor}"
systemctl enable mysqld &>>${log}
systemctl restart mysqld &>>${log}
VALIDATE $?

echo -e "${color} change the default root password ${nocolor}"
mysql_secure_installation --set-root-pass RoboShop@1 &>>${log}
VALIDATE $?

echo -e "${color} check the new password working or not ${nocolor}"
${component} -uroot -pRoboShop@1 &>>${log}
VALIDATE $?