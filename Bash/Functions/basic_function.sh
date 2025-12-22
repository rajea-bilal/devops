#!/bin/bash

# function hello() {
#     echo "Hello World"
# }

# hello

# function greet() {
#     local name="$1"
#     echo "Hello, $name"
# }

# greet "Rajea"

function params() {
    echo "Total params: $#"
    echo "Script file name: $0"
    echo "First param: $1"
    echo "First param: $2"
    echo "All params: $@"
}

params "Rajea" "Zaynab" "Aminah"