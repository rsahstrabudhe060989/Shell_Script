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
      echo -e"\e[34m Restarting\e[om \e[32m payment service[0m"

esac