
echo "\e[33m Install ngnix \e[0m" &>> /tmp/roboshop.log
yum install nginx -y

echo "\e[33m Remove the default content\e[0m" &>> /tmp/roboshop.log
rm -rf /usr/share/nginx/html/*

echo "\e[33m Download front end content\e[0m" &>> /tmp/roboshop.log
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo "\e[33m Extract the frontend content\e[0m" &>> /tmp/roboshop.log
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
#echo "\e[33mcreate ngnix proxy configuration\e[0m" &>> /tmp/roboshop.log
#vim /etc/nginx/default.d/roboshop.conf
echo "\e[33m Start & Enable Nginx service\e[0m" &>> /tmp/roboshop.log
systemctl enable nginx
systemctl readstart nginx


