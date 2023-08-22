#!bin/bash

f()   {
        echo "this is the testing purpose"     
      }

stat()
{
echo "Total number of sessions :$(who | wc -l)"
echo "Todays date is $(date +%F )"

}

echo "priting stat function"
stat