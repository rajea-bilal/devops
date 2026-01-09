#!/bin/bash

# Create a script that checks if a file exists and displays its permissions.

# Requirements:
# Prompt user for a filename
# Check if the file exists
# If it exists, check if it's readable, writable, and executable
# Display appropriate messages for each permission

# Example output:
# Enter filename to check: /etc/passwd
# File '/etc/passwd' exists. ✓ File is readable ✓ File is writable ✗ File is not executable

function file_checker_permissions() {

    local permissions;
    echo "Enter filename to check"
    read filename

    

    if [[ -f "$filename" ]]; then
        echo "File '$filename' exists."
        permissions=$(ls -l $filename)
         echo $permissions

        if [[ -r "$filename" ]]; then
            echo "✓ File is readable"
        else 
            echo "✗ File is not readable"
        fi

        if [[ -w "$filename" ]]; then
            echo "✓ File is writable"
        else 
            echo "✗ File is not writable"
        fi

        if [[ -x "$filename" ]]; then
            echo "✓ File is executable"
        else 
            echo "✗ File is not executable"
        fi

       
        
    else 
        echo "File doesnt exist"
    fi 
    
    
    
    
}


file_checker_permissions 













