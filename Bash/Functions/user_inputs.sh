#!/bin/bash

# function user_input() {
#     echo "What is your name?"
#     read name
#     echo "Hello, $name"
# }

# user_input

function greet() {
    local name

    if [ $# -eq 0 ] 
        then
            echo "What is your name"
            read name
    else 
        name=$1
    fi

    echo "Hello, $name"
}

greet "Rajea"