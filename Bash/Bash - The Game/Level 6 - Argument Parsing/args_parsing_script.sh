#!/bin/bash

# Mission: Write a script that accepts a filename as an argument and prints the number of lines in that file. If no filename is provided, display a message saying 'No file provided'.

function parse_args() {
    local filename=$1

# if filename was not provided
    if [ ! -f "$filename" ]; then
        echo "No file was provided"
        return 1
     fi

    count=0
    while read -r line 
    do
        if [[ -n ${line//[[:space:]]/} ]]; then # if line contains text, only then add it towards the count
        ((count++))
        else 
            continue # empty line, skip loop to next line
        fi
            
    done < "$filename"
   
    echo "Total lines in the file: $count"
}

parse_args 