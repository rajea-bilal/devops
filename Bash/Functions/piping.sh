#!/bin/bash

get_file_count() {
# take the first argument passed to the function and save it as directory
    local directory='$1'
    local file_count
 
    file_count=$(ls "$directory" | wc -l)
    echo "Number of files: $file_count"
}

get_file_count "./"


search_logs() {
    local search_term='$1'
    grep "$search_term" log.txt | awk '{ print $2 }'
}



