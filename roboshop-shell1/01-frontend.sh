source common.sh
echo -e "\e[33m Install nginx \e[0m"
yum install nginx -y &>> /tmp/roboshop.log
VALIDATE $? "ngnix installed"

echo -e "\e[33m Remove the default content\e[0m"
rm -rf /usr/share/nginx/html/* &>> /tmp/roboshop.log
VALIDATE $? "Remove default content"

echo -e "\e[33m Download front end content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>> /tmp/roboshop.log
VALIDATE $? "download content"

echo -e "\e[33m Extract the frontend content\e[0m"
cd /usr/share/nginx/html  &>> /tmp/roboshop.logf
unzip /tmp/frontend.zip &>> /tmp/roboshop.log
VALIDATE $? "extract content"

echo -e "\e[33m Update frontend config \e[0m"
cp /home/centos/d73/roboshop-shell1/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log
VALIDATE $? "update roboshop.conf"

echo -e "\e[33m Start & Enable Nginx service\e[0m"
systemctl enable nginx &>> /tmp/roboshop.log
systemctl restart nginx &>> /tmp/roboshop.log

VALIDATE $? "restart ngnix"


