#!/bin/bash

function copies_files() {
    # take the directory, loop through its contents - txt files, each iteration we copy that .txt file into a new directory
    echo "What should be the name of the new directory"
    read destination

    local directory=$1
    local current_file

# first we check if directory exists
    if [[ ! -d $directory ]]; then 
        echo "This is not a valid directory"
        return 1
    fi

# make the destination folder
    mkdir "$destination"

# loop through the txt files inside the dir 
# each iteration copy them to the destination dir
    for file in "$directory/*.txt"; 
    do 
       cp $file $destination
    done
}

copies_files "../Arena/"