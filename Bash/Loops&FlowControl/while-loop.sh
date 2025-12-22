#!/bin/bash

# count=1

# while [ $count -le 5 ]
# do 
#     echo "Count: $count"
#     ((count++))
# done

fruits=("apples" "cherries" "pomegranates")
index=0

# while index is less tha the number of fruits in the array, keep looping
# fruits[@] -- all items in the fruits array
# # -- how many
#  ${#fruits[@]} -- total number of fruits in the list/array, ie 3
while [ $index -lt ${#fruits[@]} ] 
do 
    echo "Fruit: ${fruits[$index]}"
    ((index++))
done