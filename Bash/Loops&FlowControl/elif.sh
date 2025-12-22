#!/bin/bash

# age=15
# if [ $age -gt 18 ]
# then 
#     echo "You are an adult"
# else 
#     echo "You are a minor!"
# fi

score=85

if [ $score -ge 90 ]
then 
    echo "Execellent"
elif [ $score -ge 80 ] 
then 
    echo "Good!"
else 
    echo "Better luck next time!"
fi