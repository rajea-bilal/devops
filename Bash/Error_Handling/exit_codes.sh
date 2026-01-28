#!/bin/bash

# command -v git 2>/dev/null

# if [[ $? -ne 0 ]]; then
#     echo "git is not installed"
#     exit 1
# else 
#     echo "git is installed on the system"
# fi

# set -e

# echo "Before the script"

# nonexistentcommand

# echo "After the script"

# set -u

# x=10
# y=20
# z=$((x+y+w))
# result="Result is $z"

# set -x

# echo "Starting the script"

# x=10
# y=20
# z=$((x+y))

# echo "The value of Z is $z"

# set -eux

# echo "Script starts"

# x=10

# echo "The value of x is $x"

# nonexistentcommand

# --------------------
set -o nounset

echo "Value of $x"

# --------------------
set -o errexit

echo "This is a test"

nonexistentcommand

echo "This is another test"

# ------------------------

set -o pipefail

cat nonexistentfile | grep "something"