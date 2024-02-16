
log="/tmp/roboshop.log"

USERID=$(id -u)

VALIDATE(){
if [ $1 -ne 0 ]; then
	echo "$2 ... FAILURE"
	exit 1
else
	echo "$2 ... SUCCESS"
fi
}

if [ $USERID -ne 0 ]; then
	echo "You need to be root user to execute this script"
	exit 1
fi

nodejs(){

  echo -e "\e[33m disable NodeJs \e[0m"
  dnf module disable nodejs -y &>>${log}


  echo -e "\e[33m enable nodeJs module \e[0m"
  dnf module enable nodejs:18 -y &>>${log}
  VALIDATE $?

  echo -e "\e[33m Install nodejs \e[0m"
  dnf install nodejs -y &>>${log}
  VALIDATE $?


  #echo -e "\e[33m remove application ${component} \e[0m"
  #id roboshop &>>${log}
  #VALIDATE $?

  echo -e "\e[33m Add application ${component} \e[0m"
  id roboshop &>>${log}
  userdel roboshop &>>${log}
  useradd roboshop &>>${log}
  VALIDATE $?

  echo -e "\e[33m remove add directory \e[0m"
  rm -rf /app
  VALIDATE $?

  echo -e "\e[33m add directory \e[0m"
  mkdir /app &>>${log}
  VALIDATE $?

  echo -e "\e[33m  Download the application code \e[0m"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
  cd /app &>> ${log} &>>${log}
  VALIDATE $?

  echo -e "\e[33m  Unzip  application code \e[0m"
  unzip /tmp/${component}.zip &>>${log}

  VALIDATE $?

  cd /app &>> ${log} &>>${log}
  VALIDATE $?

  echo -e "\e[33m Install npm\e[0m"
  npm install &>>${log}
  VALIDATE $?

  echo -e "\e[33m Setup SystemD ${component} Service \e[0m"
  cp /home/centos/d73/roboshop-shell1/${component}.service  /etc/systemd/system/${component}.service &>>${log}
  cp /home/centos/d73/roboshop-shell1/mongo.repo  /etc/yum.repos.d/mongo.repo &>>${log}
  VALIDATE $?
}