#!/bin/bash

# Mission: Write a script that:

# 1. Creates a directory called Arena_Boss.
# 2. Creates 5 text files inside the directory, named file1.txt to file5.txt.
# 3. Generates a random number of lines (between 10 and 20) in each file.
# 4. Sorts these files by their size and displays the list.
# 5. Checks if any of the files contain the word 'Victory', and if found, moves the file to a directory called Victory_Archive.

function boss_script() {
    local directory="./Arena_Boss"

    if [ ! -d "$directory" ]; then
        mkdir "$directory"
    fi

    for((i=1;i<=5;i++)); 
    do
        if [ -e "$directory"/file"$i".txt ]; 
        then
            continue
        else 
            touch "$directory"/file"$i".txt 

            number=$((10 + RANDOM % 11))
            for((j=1;j<="$number";j++))
            do
                echo "this is a text line being added to a file" >> "$directory"/file"$i".txt
            done
        fi
    done 

    # Sorts these files by their size and displays the list.
    find "$directory" -type f -name "*.txt" -exec ls -lh {} + | sort -k 5,5 -h | awk '{ print $5, $9 }'

    # Checks if any of the files contain the word 'Victory', and if found, moves the file to a directory called Victory_Archive.
    grep -l "Victory" "$directory"/*.txt | while read -r file; 
    do
        mv "$file" "./Victory_Archive"
    done
    
}

boss_script 