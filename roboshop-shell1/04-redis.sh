echo -e "\e[33mInstall rpm\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo -e "\e[33m[33mEnable redis 6.2\e[0m"
yum module enable redis:remi-6.2 -y

echo -e "\e[33mInstall redis\e[0m"
yum install redis -y

echo -e "\e[33m update listen address\e[0m"
sed -i -e "s/127.0.0.1 to 0.0.0.0"  /etc/redis.conf /etc/redis/redis.conf

"\e[33mEnable and restart redis\e[0m"
systemctl enable redis
systemctl start redis