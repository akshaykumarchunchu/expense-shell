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
    if [ $1 -ne 0 ]
    then 
        echo -e "$2..$R is Failure $N"
    else
        echo -e "$2..$G is Success $N"
    fi
}

if [ $? -ne 0 ]
then 
    echo "You're not a Superuser"
    exit 1
else    
    echo "You're a Superuser"
fi

dnf module disable nodejs -y &>>$LOGFILE
VALIDATE $? "disable nodejs lower version"

dnf module enable nodejs:20 -y &>>$LOGFILE
VALIDATE $? "enable nodejs newer version"

dnf install nodejs -y &>>$LOGFILE
VALIDATE $? "inatall nodejs"

id expense &>>$LOGFILE
#VALIDATE $? "user add expense"
if [ $? -ne 0 ]
then 
    useradd expense &>>$LOGFILE
    VALIDATE $? "user add expense"
else
    echo "user expense already added..SKIPPING"
fi



