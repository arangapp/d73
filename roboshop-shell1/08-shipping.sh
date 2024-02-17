source common.sh
component=shipping

echo -e "${color} Install Maven ${nocolor}"
dnf install maven -y &>>${log}
status_check $?

echo -e "${color} Add application ${component} ${nocolor}"
id roboshop &>>${log}
userdel roboshop &>>${log}
useradd roboshop &>>${log}
status_check $?

echo -e "${color} remove add directory ${nocolor}"
rm -rf /app
status_check $?

echo -e "${color} add directory ${nocolor}"
mkdir /app &>>${log}
status_check $?

echo -e "${color}  Download the application code ${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
cd /app &>>${log}
unzip /tmp/${component}.zip &>>${log}
status_check $?

echo -e "${color} download the dependencies & build the application ${nocolor}"
cd /app
mvn clean package &>>${log}
mv target/${component}-1.0.jar ${component}.jar &>>${log}
status_check $?

echo -e "${color} setup SystemD ${component} Service ${nocolor}"
cp /home/centos/d73/roboshop-shell1/${component}.service /etc/systemd/system/${component}.service &>>${log}
status_check $?

echo -e "${color} Install mysql client ${nocolor}"
dnf install mysql -y  &>>${log}
status_check $?

echo -e "${color}  Load the service ${nocolor}"
systemctl daemon-reload &>>${log}
status_check $?

echo -e "${color} Load Schema ${nocolor}"
mysql  -h mysql-dev.adevlearn.shop -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${log}
status_check $?

echo -e "${color} enable & restart Server ${nocolor}"
systemctl enable ${component} &>>${log}
systemctl restart ${component} &>>${log}
status_check $?

