source common.sh
component=${component}

echo -e "\e[33m Install Maven \e[0m"
dnf install maven -y &>>${log}
VALIDATE $?

echo -e "\e[33m Add Application ${component} \e[0m"
useradd roboshop &>>${log}
VALIDATE $?

echo -e "\e[33m setup an app directory \e[0m"
mkdir /app &>>${log}
VALIDATE $?

echo -e "\e[33m  Download the application code \e[0m"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
cd /app &>>${log}
unzip /tmp/${component}.zip &>>${log}
VALIDATE $?

echo -e "\e[33m download the dependencies & build the application \e[0m"
cd /app
mvn clean package &>>${log}
mv target/${component}-1.0.jar ${component}.jar &>>${log}
VALIDATE $?

echo -e "\e[33m setup SystemD ${component} Service \e[0m"
cp /home/centos/d73/roboshop-shell1/${component}.service /etc/systemd/system/${component}.service &>>${log}
VALIDATE $?

echo -e "\e[33m Install ${component} client \e[0m"
dnf install ${component} -y  &>>${log}
VALIDATE $?

echo -e "\e[33m  Load the service \e[0m"
systemctl daemon-reload &>>${log}
VALIDATE $?

echo -e "\e[33m Load Schema \e[0m"
${component} -h ${component}-dev.adevlearn.shop -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${log}
VALIDATE $?

echo -e "\e[33m enable & restart Server \e[0m"
systemctl enable ${component} &>>${log}
systemctl restart ${component} &>>${log}
VALIDATE $?

