#!bin/bash


action=$1

case $action in

     start)
      echo " Starting Payment Service"
      ;;
      stop) 
      echo "Stopping Payment Service"
      ;;
      restart)
      echo "Restarting payment service"

esac