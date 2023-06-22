echo -e "\e[33m Install python3.6 \e[0m"
yum install python36 gcc python3-devel -y &>> /tmp/roboshop.log

echo -e "\e[33m add application user \e[0m"
useradd roboshop &>> /tmp/roboshop.log

echo -e "\e[33m Set an app directory \e[0m"
mkdir /app

echo -e "\e[33m Download the Application code \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>> /tmp/roboshop.log
cd /app
unzip /tmp/payment.zip &>> /tmp/roboshop.log

echo -e "\e[33m Download dependencies \e[0m"
cd /app
pip3.6 install -r requirements.txt &>> /tmp/roboshop.log

echo -e "\e[33mSetup SystemD Payment Service \e[0m"
cp /home/centos/d73/roboshop-shell1/payment.service  /etc/systemd/system/payment.service &>> /tmp/roboshop.log

echo -e "\e[33m Load the service \e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log

echo -e "\e[33m Enable & restart service \e[0m"
systemctl enable payment &>> /tmp/roboshop.log
systemctl restart payment &>> /tmp/roboshop.log

