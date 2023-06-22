source common.sh
echo -e "\${color} Install ngnix \${nocolor}"
yum install nginx -y &>>${log}

echo-e "\${color} Remove the default content\${nocolor}"
rm -rf /usr/share/nginx/html/* &>>${log}

echo-e "\${color} Download front end content\${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>>${log}

echo -e "\${color} Extract the frontend content\${nocolor}"
cd /usr/share/nginx/html &>>${log}
unzip /tmp/${component}.zip &>>${log}
#echo "\e[33mcreate ngnix proxy configuration\e[0m" &>>/tmp/roboshop.log
#vim /etc/nginx/default.d/roboshop.conf
echo-e "\${color} Start & Enable Nginx service\${nocolor}"
systemctl enable nginx &>>${log}
systemctl readstart nginx &>>${log}


