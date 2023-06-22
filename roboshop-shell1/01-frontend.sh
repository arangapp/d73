source common.sh
echo -e "\${color} Install ngnix \${nocolor}"
yum install nginx -y &>>${log}

echo-e "\${color} Remove the default content\${nocolor}"
rm -rf /usr/share/nginx/html/* &>>${log}

echo-e "\${color} Download front end content\${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip

echo -e "\${color} Extract the frontend content\${nocolor}"
cd /usr/share/nginx/html &>>${log}
unzip /tmp/${component}.zip &>>${log}
echo "\e[33mUpdate frontend config\e[0m"
cd roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log}
echo-e "\${color} Start & Enable Nginx service\${nocolor}"
systemctl enable nginx &>>${log}
systemctl readstart nginx &>>${log}


