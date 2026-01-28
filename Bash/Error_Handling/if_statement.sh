#!/bin/bash

FILE="/nonexistent"

if [[ -f "$FILE" ]]; then
    echo "File exists"
else 
    echo "File doesn't exist"
fi
