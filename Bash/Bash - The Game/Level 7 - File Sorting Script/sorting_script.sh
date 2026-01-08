#!/bin/bash

# Mission: Write a script that sorts all .txt files in a directory by their size, from smallest to largest, and displays the sorted list.

# pass the directory as an argument
# function counts the total number of text files
# then iteratoes through txt file in the folder
# for each txt file, it calculates the number of lines
# sort files in the folder based on size; smallest to largest

function sorting() {
    local directory="$1"

    sorted_count=0
    echo "Directory passed: $directory"
   for file in "$directory"/*.txt
   do
         # the current txt file

        count=0 # to store the total number of lines each txt file to calculate size
    
        while IFS= read -r line || [[ -n "$line" ]] # count the total text inside each txt file
        do
            if [[ -n ${line//[[:space:]]/} ]]; then
            ((count++))
            else 
                continue
            fi
        done < "$file"
        
        echo "$count $(basename "$file")" 

   done | sort -n | while read -r count filename
   do
        echo "count=$count filename=$filename"
        ((sorted_count++))
        mv "$directory/$filename" "$directory/$sorted_count-$filename"
   done 

}

sorting "./TextFiles"