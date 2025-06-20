#!/bin/bash

userid=$(id -u)

TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d '.' -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -eq 0 ]
    then 
        echo "$2 is a failure"
        exit 1
    else 
        echo "$2 is a Success"
    fi 
}

if [ $userid -ne 0 ]
then 
    echo "Your a not superuser"
    exit 1
else 
    echo "Your a superuser"
fi

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "installing mysql server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "enable mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Start mysql server"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
VALIDATE $? "Set up Password"
