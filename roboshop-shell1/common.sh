
log="/tmp/roboshop.log"
color="\e[33m"
nocolor="\e[0m"

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

  echo -e "${color} disable NodeJs ${nocolor}"
  dnf module disable nodejs -y &>>${log}


  echo -e "${color} enable nodeJs module ${nocolor}"
  dnf module enable nodejs:18 -y &>>${log}
  VALIDATE $?

  echo -e "${color} Install nodejs ${nocolor}"
  dnf install nodejs -y &>>${log}
  VALIDATE $?


  #echo -e "${color} remove application ${component} ${nocolor}"
  #id roboshop &>>${log}
  #VALIDATE $?

  echo -e "${color} Add application ${component} ${nocolor}"
  id roboshop &>>${log}
  userdel roboshop &>>${log}
  useradd roboshop &>>${log}
  VALIDATE $?

  echo -e "${color} remove add directory ${nocolor}"
  rm -rf /app
  VALIDATE $?

  echo -e "${color} add directory ${nocolor}"
  mkdir /app &>>${log}
  VALIDATE $?

  echo -e "${color}  Download the application code ${nocolor}"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
  cd /app &>> ${log} &>>${log}
  VALIDATE $?

  echo -e "${color}  Unzip  application code ${nocolor}"
  unzip /tmp/${component}.zip &>>${log}

  VALIDATE $?

  cd /app &>> ${log} &>>${log}
  VALIDATE $?

  echo -e "${color} Install npm${nocolor}"
  npm install &>>${log}
  VALIDATE $?

}