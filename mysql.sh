#!/bin/bash

userid=$(id -u)

TIMESTAMP=$(date +%f-H%-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d '.' -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2..$R is failure $N"
    else
        echo -e "$2..$G is success $N"
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


