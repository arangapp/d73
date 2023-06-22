echo -e "\e[33m Install ngnix \e[0m"
yum install nginx -y &>> /tmp/roboshop.log

echo -e "\e[33m Remove the default content\e[0m"
rm -rf /usr/share/nginx/html/* &>> /tmp/roboshop.log

echo -e "\e[33m Download front end content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>> /tmp/roboshop.log

echo -e "\e[33m Extract the frontend content\e[0m"
cd /usr/share/nginx/html  &>>/tmp/roboshop.log
unzip /tmp/frontend.zip &>>/tmp/roboshop.log
echo -e "\e[33mUpdate frontend config\e[0m" &>> /tmp/roboshop.log
#vim /etc/nginx/default.d/roboshop.conf
cp /home/centos/d73/roboshop-shell1 /etc/nginx/default.d/roboshop.conf
echo -e "\e[33m Start & Enable Nginx service\e[0m"
systemctl enable nginx &>> /tmp/roboshop.log
systemctl restart nginx &>> /tmp/roboshop.log


