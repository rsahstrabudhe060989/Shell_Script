#!bin/bash
#exit is success 0 ;rest of thr may be 1)partial failure 2) complete failure 3)partial success
#exit code of last exected command $?
echo $0 #print script name
echo $1 #takes the first value from command line
echo $2 #takes the second value from command line

echo $* #print the used variables
echo $$ #print the PID of the current process
echo $# # print number of argument
echo $? #print the exit status of last executed command

