#!/bin/bash

userid=$(id -u)

TIMESTAMP=$(date +%f-H%-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d '.' -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
echo "Enter a Password"
read mysql_root_password

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

mysql -h db.daws78s.online -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then 
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
    VALIDATE $? "MySQL Root password Setup"
else
    echo -e "MySQL Root password is already setup...$Y SKIPPING $N"
fi

    



