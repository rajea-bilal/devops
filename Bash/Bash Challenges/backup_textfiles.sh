#!/bin/bash

# Create a script that backs up all .txt files from one directory to another.

# Requirements:

# Prompt user for source directory
# Create a backup directory if it doesn't exist
# Copy all .txt files to the backup directory
# Add timestamp to backup directory name
# Display count of files backed up

# Example output:

# Enter source directory: /home/user/documents
# Backup directory created: backup_2024-11-29_14-30 Copying .txt files...
# Backup complete! Files backed up: 5

function backup_textfiles() {

    echo "Enter source directory"
    read source_dir

     local current_date=$(date +'%Y-%m-%d_%H:%M')
    local backup_dir="backup_$current_date"

    if [[ ! -d "$backup" ]]; then
       
        mkdir "$backup_dir"
        echo "Backup directory created: $backup_dir"
        echo "Copying .txt files..."
    fi

        count=0
    while read -r file;
    do
        
        cp "$file" "$backup_dir"/
        ((count++))
        
    done < <(find "$source_dir" -type f -name "*.txt")

    echo "Backup complete! Files backed up: $count"


}

backup_textfiles

