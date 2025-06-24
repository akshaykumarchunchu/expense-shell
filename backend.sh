#!/bin/bash

userid=$(id -u)

TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d '.' -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo "$2..is Failure"
    else
        echo "$2..is Success"
    fi
}

if [ $? -ne 0 ]
then 
    echo "You're not a Superuser"
    exit 1
else    
    echo "You're a Superuser"
fi

