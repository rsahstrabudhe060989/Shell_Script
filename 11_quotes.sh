#!/bin/bash
# " " : They dont effect the power of special variable
# ' ' : They will effect the power of special variable
a=10

echo "Printing the value of a:$a"
echo 'Printing the value of a:$a'
echo $?
echo '$?'
