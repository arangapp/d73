
log="/tmp/roboshop.log"
color="\e[33m"
nocolor="\e[0m"

USERID=$(id -u)

status_check(){
if [ $1 -ne 0 ]; then
	echo "$2 ... FAILURE"
	exit1
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
  status_check $?

  echo -e "${color} Install nodejs ${nocolor}"
  dnf install nodejs -y &>>${log}
  status_check $?


  #echo -e "${color} remove application ${component} ${nocolor}"
  #id roboshop &>>${log}
  #status_check $?

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
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
  cd /app &>> ${log} &>>${log}
  status_check $?

  echo -e "${color}  Unzip  application code ${nocolor}"
  unzip /tmp/${component}.zip &>>${log}

  status_check $?

  cd /app &>> ${log} &>>${log}
  status_check $?

  echo -e "${color} Install npm${nocolor}"
  npm install &>>${log}
  status_check $?

}