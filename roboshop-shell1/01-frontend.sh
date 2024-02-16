source common.sh
component=frontend

echo -e "\e[33m Install nginx \e[0m"
dnf install nginx -y  ${log}
VALIDATE $? "ngnix installed"

echo -e "\e[33m Remove the default content\e[0m"
rm -rf /usr/share/nginx/html/* &>>${log}
VALIDATE $? "Remove default content"

echo -e "\e[33m Download front end content\e[0m"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>>${log}
VALIDATE $? "download content"

echo -e "\e[33m Extract the ${component} content\e[0m"
cd /usr/share/nginx/html  &>>${log}
unzip /tmp/${component}.zip &>>${log}
VALIDATE $? "extract content"

echo -e "\e[33m Update ${component} config \e[0m"
cp /home/centos/d73/roboshop-shell1/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log}
VALIDATE $? "update roboshop.conf"

echo -e "\e[33m Start & Enable Nginx service\e[0m"
systemctl enable nginx &>>${log}
systemctl restart nginx &>>${log}

VALIDATE $? "restart ngnix"


