#!bin/bash


action=$1

case $action in

     start)
      echo -e " \e[32m Starting Payment Service \e [0m"
      ;;
      stop) 
      echo -e "\e [31m Stopping Payment Service \e [0m"
      ;;
      restart)
      echo -e"\e [34m Restarting [0m  [32m payment service \e [0m "

esac