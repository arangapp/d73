echo -e "\e[33m Setup the MongoDB repo file \e[0m"
cp /home/centos/d73/roboshop-shell1/mongo.repo  /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log

echo -e "\e[33m Install MongoDB \e[0m"
yum install mongodb-org -y &>> /tmp/roboshop.log

echo -e "\e[33m Update listen address \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>> /tmp/roboshop.log

echo -e "\e[33m Enable & Restart MongoDB \e[0m"
systemctl enable mongod &>> /tmp/roboshop.log
systemctl restart mongod  &>> /tmp/roboshop.log


