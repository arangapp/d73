echo -e "\e[33m Install ngnix \e[0m"
yum install nginx -y &>>/tmp/roboshop

echo-e "\e[33m Remove the default content\e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop

echo-e "\e[33m Download front end content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[33m Extract the frontend content\e[0m"
cd /usr/share/nginx/html &>>/tmp/roboshop
unzip /tmp/frontend.zip &>>/tmp/roboshop
echo "\e[33mUpdate frontend config\e[0m"
cd roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop
echo-e "\e[33m Start & Enable Nginx service\e[0m"
systemctl enable nginx &>>/tmp/roboshop
systemctl readstart nginx &>>/tmp/roboshop


