source common.sh
log="/tmp/roboshop.log"

echo -e "\e[33m Install python3.6 \e[0m"
dnf install python36 gcc python3-devel -y &>>${log}
VALIDATE $?

echo -e "\e[33m add application user \e[0m"
id roboshop &>>${log}
userdel roboshop &>>${log}
useradd roboshop &>>${log}
VALIDATE $?

echo -e "\e[33m Set an app directory \e[0m"
mkdir /app &>>${log}
VALIDATE $?

echo -e "\e[33m Download the Application code \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>${log}
cd /app &>>${log}
unzip /tmp/payment.zip &>>${log}
VALIDATE $?

echo -e "\e[33m Download dependencies \e[0m"
cd /app &>>${log}
pip3.6 install -r requirements.txt &>>${log}
VALIDATE $?

echo -e "\e[33mSetup SystemD Payment Service \e[0m"
cp /home/centos/d73/roboshop-shell1/payment.service  /etc/systemd/system/payment.service &>>${log}
VALIDATE $?

echo -e "\e[33m Load the service \e[0m"
systemctl daemon-reload &>>${log}
VALIDATE $?

echo -e "\e[33m Enable & restart service \e[0m"
systemctl enable payment &>>${log}
systemctl restart payment &>>${log}
VALIDATE $?
