#!/bin/bash

function ask_install_folder()
{
    read -p  "Whrer is your install folder location:" FOLDER
    while true
    do
        echo "Please confirm the folder location is $FOLDER"
        read -p "Are you sure? (y or Y) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            break
        else
            read -p "please input folder location again:" FOLDER
        fi
    done
}
function check_install_service()
{
    while true
    do
        if [ -f $FOLDER/test.exe ] 
                                              ## && [ -f $FOLDER/test.exe ]
        then
            #write folder
            sed -i "/WorkingDirectory=/s@=.*@=$FOLDER@" ./install.service
            sed -i "/ExecStart=/s@=.*@=$FOLDER/start.sh -f@" ./install.service
            FOLDER_USER=$(ls -l $FOLDER/start.sh | awk '{print $3}')
            sed -i "/User=/s/=.*/=$FOLDER_USER/" ./install.service
            sudo cp ./install.service /etc/systemd/system
            sudo systemctl daemon-reload

            break
        else
            echo "Wrong folder."
            echo "$FOLDER/test.exe and FOLDER_STOP/test.exe does not exists. please input folder location again."
            exit
        fi
    done
}
function start_install_service()
{
    sudo systemctl enable install.service

    echo "----------------------------------------"
    echo "Your install folder User is => $FOLDER_USER"
    echo "----------------------------------------"
    echo "Start install service with [systemctl start install]."
    echo "Check install status with [systemctl status install]."
}

ask_install_folder
check_install_service
start_install_service
