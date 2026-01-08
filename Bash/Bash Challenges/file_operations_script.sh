#!/bin/bash


# Create a script that automates directory and file creation.

# Requirements:

# Create a directory called bash_demo
# Navigate into the directory
# Create a file called demo.txt
# Write text to the file (include current date)
# Display the file contents

# Example output:

# Directory 'bash_demo' created. File 'demo.txt' created.
# File contents: This file was created by a Bash script on 2024-11-29



function file_operations_script() {

    local current_dir=$(pwd)
    local directory="./bash_demo"
    local file_name="demo.txt"
    local current_date=$(date +'%Y-%m-%d')
    local file_text="This file was created by a Bash script on $current_date"

    echo "current date, $current_date"
    # only create directory if it doesnt already exist
    if [ ! -d "$directory" ];
    then
        mkdir "$directory"
    fi


    cd "$directory"
  
    # stopping the script if the cd command failed. 
    if [[ $? -ne 0 ]]; then
        echo "We were not able to navigate into $directory"
        exit 1
    fi

    touch "$file_name"
    echo "$file_text" > "$file_name"

    cat "$file_name"

    cd "$current_dir"
    echo $PWD


}

file_operations_script









