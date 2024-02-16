source common.sh
component=mysql

echo -e "\e[33m disable ${component} 8 version \e[0m"
dnf module disable ${component} -y  &>>${log}
VALIDATE $?

echo -e "\e[33m check the directory exits \e[0m"
ls -ld /etc/yum.repos.d/ &>>${log}
VALIDATE $?

echo -e "\e[33m create a directory \e[0m"
sudo mkdir -p /etc/yum.repos.d/
VALIDATE $?

echo -e "\e[33m Setup the MySQL5.7 repo file \e[0m"
cp /home/centos/d73/roboshop-shell1/${component}.repo /etc/yum.repos.d/${component}.repo  &>>${log}
VALIDATE $?

echo -e "\e[33m Install ${component} Server \e[0m"
dnf install ${component}-community-server -y &>>${log}
VALIDATE $?

echo -e "\e[33m enable & restart MqSql \e[0m"
systemctl enable mysqld &>>${log}
systemctl restart mysqld &>>${log}
VALIDATE $?

echo -e "\e[33m change the default root password \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>${log}
VALIDATE $?

echo -e "\e[33m check the new password working or not \e[0m"
${component} -uroot -pRoboShop@1 &>>${log}
VALIDATE $?