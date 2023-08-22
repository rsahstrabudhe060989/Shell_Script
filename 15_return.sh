#!bin/bash
<< comments
exit will pull out of the script
return , this will just take out the functions.
comments


f()   {
        echo "this is called from inside function nesting function call"     
        echo -e "\e[31m name you enter \e[0m  $NAME "
      }

stat()
{
echo "Total number of sessions :$(who | wc -l)"
echo "Todays date is $(date +%F )"
echo "Todays date is $(uptime | awk -F : '{print $NF}')"
echo -e "\e[32m This calling function from another function \e[0m "
read -p "enter the name of user :" NAME
#exit 0 this will exit from the function and dont execute next part of script
return # this will only exit from this funcion
f
}

echo "priting stat function"
stat
echo -e "\t\t stat and sample functions are completed"

# uptime | awk -F : '{print $1}'
#  uptime | awk -F : '{print $NF}'
#  uptime | awk -F : '{print $NF}' | awk -F , '{print $1}'
# echo "Todays date is $(uptime | awk -F : '{print $NF}')"
