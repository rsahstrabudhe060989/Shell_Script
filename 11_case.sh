#!bin/bash


action=$1

case $action in

     start)
      echo -e " \e[32m Starting Payment Service \e[0m"
      ;;
      stop) 
      echo -e "\e[31m Stopping\e[0m  \e[32m Payment Service \e[0m"
      ;;
      restart)
      echo -e " \e[32m reStarting Payment Service \e[0m"
      ;;
      *)
      echo -e "\e[32m Wrong\e[0m"
esac