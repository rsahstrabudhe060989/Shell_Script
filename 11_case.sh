#!bin/bash


action=$1

case $action in

     start)
      echo -e " \e[32m Starting Payment Service \e [0m]"
      ;;
      stop) 
      echo "Stopping Payment Service"
      ;;
      restart)
      echo "Restarting payment service"

esac