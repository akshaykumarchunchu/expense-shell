#!/bin/bash

userid=$(id -u)

TIMESTAMP=$(date +%f-H%-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d '.' -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo "$2 is failure"
    else
        echo "$2 is success"
    fi
    }

if [ $userid -ne 0 ]
then 
    echo "Please enter with super user"
    exit 1
else    
    echo "Your a Super user"
fi

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "Installing mysql server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enable mysql"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Start mysqld"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
VALIDATE $? "Set Password"


