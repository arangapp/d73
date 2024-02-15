source common.sh

echo -e "\e[33m Setup the MongoDB repo file \e[0m"
cp /home/centos/d73/roboshop-shell1/mongo.repo  /etc/yum.repos.d/mongo.repo &>>${log}
VALIDATE $? "Setup mongodb repo"

echo -e "\e[33m Install MongoDB \e[0m"
yum install mongodb-org -y &>>${log}
VALIDATE $? "Install mongodb "

echo -e "\e[33m Update listen address \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${log}
VALIDATE $? "update lister address"

echo -e "\e[33m Enable & Restart MongoDB \e[0m"
systemctl enable mongod &>>${log}
systemctl restart mongod  &>>${log}
VALIDATE $? "restart"


