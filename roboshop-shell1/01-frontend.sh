source common.sh
echo -e "\${color} Install ngnix \${nocolor}" &>>${log}
yum install nginx -y

echo-e "\${color} Remove the default content\${nocolor}" &>>${log}
rm -rf /usr/share/nginx/html/*

echo-e "\${color} Download front end content\${nocolor}" &>>${log}
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip

echo -e "\${color} Extract the frontend content\${nocolor}" &>>${log}
cd /usr/share/nginx/html
unzip /tmp/${component}.zip
#echo "\e[33mcreate ngnix proxy configuration\e[0m" &>>/tmp/roboshop.log
#vim /etc/nginx/default.d/roboshop.conf
echo-e "\${color} Start & Enable Nginx service\${nocolor}" &>>${log}
systemctl enable nginx
systemctl readstart nginx


