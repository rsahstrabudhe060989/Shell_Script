#!bin/bash


action=$1

case $action in

     start)
      echo -e " \e[32m Starting Payment Service \e[0m"
      exit 0
      ;;
      stop) 
      echo -e "\e[31m Stopping\e[0m  \e[32m Payment Service \e[0m"
      exit 2
      ;;
      restart)
      echo -e " \e[32m reStarting Payment Service \e[0m"
      exit 3
      ;;
      *)
      echo -e "\e[32m Wrong\e[0m"
      exit 4
esac