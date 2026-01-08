#!/bin/bash

# Mission: Create a script that outputs the numbers 1 to 10, one number per line.

function output_numbers() {

    for((i=1;i<=10;i++))
    do
        echo "$i"

    done
}

output_numbers