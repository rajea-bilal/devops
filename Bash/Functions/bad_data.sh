#!/bin/bash

function handleData() {
    local age=$1

    # checking if the user inputted age is a numeric value using regex
    if [[ ! $age =~ ^[0-9]+$ ]] 
    then
        echo "Invalid age. Please provide a numeric value."
        return 1
    fi

    if (( age < 18 ))
    then 
        echo "Sorry, you must be at least 18 years old."
        return 1
    fi

    echo "Congratulations! You are eligible"
    return 0
}

echo "What is your age?"
read user_age
handleData $user_age
exit_code=$?

if [ exit_code != 0 ]
then
    echo "Input validation failed."
else 
    echo "Succesful input validation"
fi