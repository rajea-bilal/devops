#!/bin/bash

# Mission: Write a script that checks if a file named hero.txt exists in the Arena directory. If it does, print Hero found!; otherwise, print Hero missing!.

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