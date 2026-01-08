#!/bin/bash

# Mission: Combine what you've learned! Write a script that:

# 1. Creates a directory names 'Battlefield'
# 2. Inside Battlefield, create files named knight.txt, sorcerer.txt, and rogue.txt.
# 3. Check if knight.txt exists; if it does, move it to a new directory called Archive.
# 4. List the contents of both Battlefield and Archive.

function boss_script() {
    echo "What should be the name of the directory"
    read directory_name

# create directory
    mkdir "$directory_name"

 
# all the filenames passed to the function as arguments and saved as separate variables, for each filename, we would create a file inside the newly created dir
for filename in "$@"
do
     touch $directory_name/$filename
done

# check if knight.txt exists
# if it does, move it to a new directory called Archive
    if [[ -f "Battlefield"/$1 ]]; 
    then
        echo "knight.txt exists inside Battlefield directory"
        mkdir "Archive"
        mv Battlefield/$1 "Archive/"
    fi
}

boss_script "knight.txt" "sorcerer.txt" "rogue.txt"