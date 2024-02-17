source common.sh
component=shipping

echo -e "${color} Install Maven ${nocolor}"
dnf install maven -y &>>${log}
VALIDATE $?

echo -e "${color} Add Application ${component} ${nocolor}"
useradd roboshop &>>${log}
VALIDATE $?

echo -e "${color} setup an app directory ${nocolor}"
mkdir /app &>>${log}
VALIDATE $?

echo -e "${color}  Download the application code ${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
cd /app &>>${log}
unzip /tmp/${component}.zip &>>${log}
VALIDATE $?

echo -e "${color} download the dependencies & build the application ${nocolor}"
cd /app
mvn clean package &>>${log}
mv target/${component}-1.0.jar ${component}.jar &>>${log}
VALIDATE $?

echo -e "${color} setup SystemD ${component} Service ${nocolor}"
cp /home/centos/d73/roboshop-shell1/${component}.service /etc/systemd/system/${component}.service &>>${log}
VALIDATE $?

echo -e "${color} Install ${component} client ${nocolor}"
dnf install ${component} -y  &>>${log}
VALIDATE $?

echo -e "${color}  Load the service ${nocolor}"
systemctl daemon-reload &>>${log}
VALIDATE $?

echo -e "${color} Load Schema ${nocolor}"
${component} -h ${component}-dev.adevlearn.shop -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${log}
VALIDATE $?

echo -e "${color} enable & restart Server ${nocolor}"
systemctl enable ${component} &>>${log}
systemctl restart ${component} &>>${log}
VALIDATE $?

