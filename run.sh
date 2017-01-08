#!/bin/sh

while true
do
   sleep 5
   output=`rake evcard:get_car_in_shop\['中信'\]`
   result=$(echo $output | grep "canRent")
   echo $output
   if [ "$result" != "" ]; then
      /usr/bin/notify-send "发现可用车"
   fi
done
