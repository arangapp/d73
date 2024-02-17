source common.sh
component=frontend

echo -e "${color} Install nginx ${nocolor}"
dnf install nginx -y  &>>${log}
VALIDATE $? "ngnix installed"

echo -e "${color} Remove the default content${nocolor}"
rm -rf /usr/share/nginx/html/* &>>${log}
VALIDATE $? "Remove default content"

echo -e "${color} Download front end content${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>>${log}
VALIDATE $? "download content"

echo -e "${color} Extract the ${component} content${nocolor}"
cd /usr/share/nginx/html  &>>${log}
unzip /tmp/${component}.zip &>>${log}
VALIDATE $? "extract content"

echo -e "${color} Update ${component} config ${nocolor}"
cp /home/centos/d73/roboshop-shell1/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log}
VALIDATE $? "update roboshop.conf"

echo -e "${color} Start & Enable Nginx service${nocolor}"
systemctl enable nginx &>>${log}
systemctl restart nginx &>>${log}

VALIDATE $? "restart ngnix"


