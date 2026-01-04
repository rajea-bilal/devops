#!/bin/bash

function check_file() {
    local file_path=$1

    if [[ -f $1 ]]
    then
       echo "Hero found!" 
    else
        echo "Hero missing!"
    fi
}
 
check_file "../Arena/hero.txt"