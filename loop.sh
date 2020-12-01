#!/bin/bash

#to do anything+loop code

while [ -n "$1" ]; do # while loop starts
    case "$1" in
    -f)
        sleep 30;
        ;;

    *) echo -e "${ERROR} Option $1 not recognized(say anything)" ;;

    esac

done
