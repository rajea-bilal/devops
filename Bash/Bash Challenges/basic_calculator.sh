#!/bin/bash

# Create a script that takes two numbers as input and performs basic arithmetic operations (addition, subtraction, multiplication, division).

# Requirements:

# Prompt user for two numbers
# Perform all four operations
# Display the results
# Handle division by zero

# Example output:

# Enter first number: 10 Enter second number: 5
# Results: 10 + 5 = 15 10 - 5 = 5 10 × 5 = 50 10 ÷ 5 = 2

function basic_calculator() {
    echo "Enter first number"
    read first_number

    echo "Enter second number"
    read second_number

    echo "The numbers you entered are - $first_number & $second_number"
    addition=$((first_number + second_number))
    substraction=$((first_number - second_number))
    multiplication=$((first_number * second_number))
    
    if [[ $second_number -eq 0 ]]; 
    then
        division="undefined"
    else 
        division=$((first_number / second_number))
    fi

    
    
    echo "Results: $first_number + $second_number = $addition $first_number - $second_number = $substraction $first_number * $second_number = $multiplication $first_number / $second_number = $division"
   

}

basic_calculator