echo -e "\e[33mInstall rpm\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> /tmp/roboshop.log

echo -e "\e[33mEnable redis 6.2\e[0m"
yum module enable redis:remi-6.2 -y &>> /tmp/roboshop.log

echo -e "\e[33mInstall redis\e[0m"
yum install redis -y &>> /tmp/roboshop.log

echo -e "\e[33m update listen address\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/g'  /etc/redis.conf /etc/redis/redis.conf &>> /tmp/roboshop.log

echo -e "\e[33mEnable and restart redis\e[0m"
systemctl enable redis &>> /tmp/roboshop.log
systemctl start redis &>> /tmp/roboshop.log