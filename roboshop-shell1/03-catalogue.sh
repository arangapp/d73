VALIDATE(){
if [ $1 -ne 0 ]; then
	echo "$2 ... FAILURE"
	exit 1
else
	echo "$2 ... SUCCESS"
fi
}

echo -e "\e[33mSetup NodeJS repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/roboshop.log
VALIDATE $? "Setup NodeJS repo"

echo -e "\e[33mInstall Node Js\e[0m"
yum install nodejs -y &>> /tmp/roboshop.log
VALIDATE $? "Install nodeJs"

##echo -e "\e[33mremove app user\e[0m"
##rm -rf /home/roboshop &>> /tmp/roboshop.log
##VALIDATE $? "remove App user"

echo -e "\e[33madd app user\e[0m"
useradd roboshop &>> /tmp/roboshop.log
VALIDATE $? "Add App user"

echo -e "\e[33msetup an app directory\e[0m"
rm -rf /app &>> /tmp/roboshop.log
mkdir /app &>> /tmp/roboshop.log
VALIDATE $? "Setup App directory"

echo -e "\e[33mDownload the application code to created app directory\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>> /tmp/roboshop.log
cd /app
VALIDATE $? "download application code"

echo -e "\e[33mExtract code \e[0m"
unzip /tmp/catalogue.zip &>> /tmp/roboshop.log
cd /app

VALIDATE $? "extract appcode"

echo -e "\e[33mInstall npm\e[0m"
npm install &>> /tmp/roboshop.log

VALIDATE $? "Install npm"

echo -e "\e[33mSetup SystemD Catalogue Service\e[0m"
cp /home/centos/d73/roboshop-shell1/catalogue.service /etc/systemd/system/catalogue.service &>> /tmp/roboshop.log
VALIDATE $? "Setup systemd"

echo -e "\e[33mLoad the service\e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log
VALIDATE $? "load service"

echo -e "\e[33mEnable & Restart server\e[0m"
systemctl enable catalogue &>> /tmp/roboshop.log
systemctl restart catalogue &>> /tmp/roboshop.log
VALIDATE $? "enable &restart service"

echo -e "\e[33m setup mongodb repo\e[0m"
cd /home/centos/d73/roboshop-shell1/mongo.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log
VALIDATE $? "Setup mongodb repo"

echo -e "\e[33mInstall mongodb-client\e[0m"
yum install mongodb-org-shell -y &>> /tmp/roboshop.log
VALIDATE $? "Install mongodb client"

echo -e "\e[33mLoad Schema\e[0m"
mongo --host mongodb-dev.adevlearn.shop </app/schema/catalogue.js &>> /tmp/roboshop.log
VALIDATE $? "load schema"



