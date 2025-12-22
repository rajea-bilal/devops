#!/bin/bash

# break & continue in for-loop
for (( i=1; i<=5; i++ ))
do
    if [ $i -eq 3 ]
    then
        continue # skip the value 3
    fi
    echo "Number: $i"

done

# break & continue in while-loop

# count=1
# while [ $count -le 5 ] 
# do
#     if [ $count -eq 3 ] 
#     then
#         break;
#     fi
    

#     echo "Number: $count"
#     ((count++))
# done