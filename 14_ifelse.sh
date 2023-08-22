#!bin/bash
<<comment
if [ expresion1] ; then
commands
elif [experssion2] ; then
coomands
else 
 command2
fi

Operators on number :
-eq , -ne , -gt , -ge, -lt, -le
Operatiors on strings = , ==, !=
Operators  on files

[ -f file] true of file exises and regular file
[ -d xyz]  true if the file exist and it is directory

[ -z "$var" ]   This is true if var is not having any date
[ -n "$var" ]   This is true if var not having any date
comment

echo "Demonstrating simple if condtions"
action= $1

if [ "$action" == "start"] ; then
echo "Correct Value /start"
else if [ "$action" == "stop" ] ; then
echo  "Correct Value /stop"
else 
echo  "wrong Value "
fi 

