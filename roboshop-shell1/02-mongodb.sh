source common.sh

echo -e "${color} Setup the MongoDB repo file ${nocolor}"
cp /home/centos/d73/roboshop-shell1/mongo.repo  /etc/yum.repos.d/mongo.repo &>>${log}
VALIDATE $? "Setup mongodb repo"

echo -e "${color} Install MongoDB ${nocolor}"
yum install mongodb-org -y &>>${log}
VALIDATE $? "Install mongodb "

echo -e "${color} Update listen address ${nocolor}"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${log}
VALIDATE $? "update lister address"

echo -e "${color} Enable & Restart MongoDB ${nocolor}"
systemctl enable mongod &>>${log}
systemctl restart mongod  &>>${log}
VALIDATE $? "restart"


