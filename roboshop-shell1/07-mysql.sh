echo -e "\e[33m disable MySQL 8 version \e[0m"
yum module disable mysql -y &>> /tmp/roboshop.log

echo -e "\e[33m Setup the MySQL5.7 repo file \e[0m"
cp cp /home/centos/d73/roboshop-shell1/mysql.repo /etc/yum.repos.d/mysql.repo &>> /tmp/roboshop.log

echo -e "\e[33m Install MySQL Server \e[0m"
yum install mysql-community-server -y &>> /tmp/roboshop.log

echo -e "\e[33m enable & restart MqSql \e[0m"
systemctl enable mysqld &>> /tmp/roboshop.log
systemctl restart mysqld &>> /tmp/roboshop.log

echo -e "\e[33m change the default root password \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>> /tmp/roboshop.log

echo -e "\e[33m check the new password working or not \e[0m"
mysql -uroot -pRoboShop@1 &>> /tmp/roboshop.log