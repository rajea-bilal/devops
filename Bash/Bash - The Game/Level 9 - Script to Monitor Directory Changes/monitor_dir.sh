#!/bin/bash 

# Mission: Write a script that monitors a directory for any changes (file creation, modification, or deletion) and logs the changes with a timestamp.

function monitor_dir() {
    local directory="$1"
    local LOG_FILE="$2"

    if [ ! -d "$directory" ]; then
        echo "Directory does not exist"
        exit 1
    fi

    fswatch -r "$directory" | while read event; 
    do
        if [ -e "$event" ]; then
            echo "$event"
            echo "$(date +'%Y-%m-%d %H:%M:%S') File modified/created: $event" >> "$LOG_FILE"
        else 
            echo "$(date + '%Y-%m-%d %H:%M:%S') File deleted: $event" >> "$LOG_FILE"
        fi
    done
}

monitor_dir "./RandomDir" "./log.txt"
