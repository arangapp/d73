echo -e "\e[33m configure yum repos \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>> /tmp/roboshop.log

echo -e "\e[33m Configure YUM Repos for RabbitMQ \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>> /tmp/roboshop.log

echo -e "\e[33m Install RabbitMQ \e[0m"
yum install rabbitmq-server -y &>> /tmp/roboshop.log

echo -e "\e[33m create a user for the application \e[0m"
rabbitmqctl add_user roboshop roboshop123 &>> /tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> /tmp/roboshop.log

echo -e "\e[33m enable & start rabbitmq \e[0m"
systemctl enable rabbitmq-server  &>> /tmp/roboshop.log
systemctl restart rabbitmq-server  &>> /tmp/roboshop.log