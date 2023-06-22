echo -e "e\[33m Setup the MongoDB repo file \e[0m"
cd mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
decho -e "e\[33m Install MongoDB \e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log
echo -e "e\[33m Update listen address \e[0m"
sed -i -e "s/27.0.0.1 to 0.0.0.0cc" /etc/mongod.conf &>>/tmp/roboshop.log
echo -e "e\[33m Enable & Restart MongoDB \e[0m"

systemctl enable mongod &>>/tmp/roboshop.log
systemctl start mongod  &>>/tmp/roboshop.log


