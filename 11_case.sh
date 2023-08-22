#!bin/bash


action=$1

case $action in

     start)
      echo -e " \e[32m Starting Payment Service \e[0m"
      ;;
      stop) 
      echo -e "\e[31m Stopping Payment Service \e[0m"
      ;;
      restart)
      echo -e " \e[32m reStarting Payment Service \e[0m"
      ;;
esac