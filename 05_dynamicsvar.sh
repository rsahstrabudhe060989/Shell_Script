#!/bin/bash
date=" 03-07-2023"
Today= ${date +%F}

echo -e "Todays date is: \e[32m ${date} \e[0m"
echo -e "Todays date is: \e[32m ${today} \e[0m"
echo  echo first varible $0
echo  echo second varible $1
echo  echo suplied  varible $#

echo  echo suplied  varible $@

echo  echo suplied  varible $*