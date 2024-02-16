
log=/tmp/roboshop.log

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