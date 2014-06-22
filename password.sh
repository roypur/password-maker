#!/bin/bash
length=$1
entropy=`expr 50 \* $length`
echo ""

cases=5 

#The cases variable is set to 5 to avoid errors beccause cases doesent exist. Any numerical value except 123 will do.

until [ $cases -eq 123 ]
do
   password=`head -c $entropy /dev/random | tr -dc a-zA-Z0-9 | tail -c $length`
   cases=`echo $password | tr 0-9 1 | tr a-z 2 | tr A-Z 3 | grep -o . | sort -n | uniq | tr -dc 1-3`

   if [ $cases == 123 ]
   then
     echo $password
     echo ""
   fi
done

#The until statement keeps the script running until the password contains upper-case, lower-case and numbers.

#tr replaces 0-9 with 1, a-z with 2 and A-Z with 3.
#grep puts every 1, 2 and 3 on its own line.
#sort sorts the numbers the numbers.
#uniq removes duplicate lines.
#tr removes everything except 1, 2 and 3.

#The if statement checks if the password contains numbers, upper-case and lower-case by checking if $cases equals 123.
