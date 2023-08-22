#!bin/bash

f()   {
        echo "this is called from inside function nesting function call"     
        echo -e "\e[31m name you enter  $NAME \e[0m"
      }

stat()
{
echo "Total number of sessions :$(who | wc -l)"
echo "Todays date is $(date +%F )"
echo "Todays date is $(uptime | awk -F : '{print $NF}')"
echo -e "\e[32m This calling function from another function \e[0m "
read -p "enter the name of user :" NAME
f
}

echo "priting stat function"
stat

# uptime | awk -F : '{print $1}'
#  uptime | awk -F : '{print $NF}'
#  uptime | awk -F : '{print $NF}' | awk -F , '{print $1}'
# echo "Todays date is $(uptime | awk -F : '{print $NF}')"
