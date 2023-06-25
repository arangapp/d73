VALIDATE(){
if [ $1 -ne 0 ]; then
	echo "$2 ... FAILURE"
	exit 1
else
	echo "$2 ... SUCCESS"
fi
}

echo -e "\e[33m Setup the MongoDB repo file \e[0m"
cp /home/centos/d73/roboshop-shell1/mongo.repo  /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log
VALIDATE $? "Setup mongodb repo"

echo -e "\e[33m Install MongoDB \e[0m"
yum install mongodb-org -y &>> /tmp/roboshop.log
VALIDATE $? "Install mongodb "

echo -e "\e[33m Update listen address \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>> /tmp/roboshop.log
VALIDATE $? "update lister address"

echo -e "\e[33m Enable & Restart MongoDB \e[0m"
systemctl enable mongod &>> /tmp/roboshop.log
systemctl restart mongod  &>> /tmp/roboshop.log
VALIDATE $? "restart"


