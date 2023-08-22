#!/bin/bash
date=" 03-07-2023"
Today= ${date +%F}

echo -e "Todays date is: \e[32m ${date} \e[0m"
echo -e "Todays date is: \e[32m ${today} \e[0m"
echo -e "The No of login users are: \e[32m ${who | wc -l} \e[0m"