#!bin/bash

f()   {
        echo "this is the testing purpose"     
      }

stat()
{
echo "Total number of sessions :$(who | wc -l)"
echo "Todays date is $(date +%F )"
#echo " Todays avarge load ${ uptime | awk -F : '{print $NF}' | awk -F , '{print $1}'}"
echo "This calling function from another function"
f

}

echo "priting stat function"
stat

# uptime | awk -F : '{print $1}'
#  uptime | awk -F : '{print $NF}'
#  uptime | awk -F : '{print $NF}' | awk -F , '{print $1}'
