#!/bin/bash

age=19
grade=85

if [ $age -gt 18 ]; then
    echo "You are elgible because of your age"
    if [ $grade -ge 80 ]; then
        echo "Congratulations!"
        echo "You're eligible for a scholarship because of your grades"
    else 
        echo "Sorry, you're grade is not high enough"
    fi
else 
    echo "Sorry you're not old enough to be eligible for a scholarship"
fi 