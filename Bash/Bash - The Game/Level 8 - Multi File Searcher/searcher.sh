#!/bin/bash


# Mission: Create a script that searches for a specific word or phrase across all .log files in a directory and outputs the names of the files that contain the word or phrase.

# pass in directory as an arg
# function captures it, uses a for-loop to iterate over all .log files in the directory
# once the the for-loop finishes pipes the result into grep containing specific word


function searcher() {
    local directory="$1"

    if [ ! -d "$directory" ];
    then
        echo "$directory doesnt exist!"
        exit 1
    fi

   grep -l "Writing" "$directory"/*.log
}

searcher "./LogDirectory"