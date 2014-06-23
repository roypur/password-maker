#!/bin/bash
length=10
option=${1-10}
option=`echo $option | tr -dc 0-9`

if [ $option -ge 1 ]
then
    length=`echo $option`
fi

entropy=`expr 50 \* $length`
echo ""

cases=5
#The cases variable is set to 5 to avoid errors beccause cases doesent exist. Any numerical value except 123 will do.

until [ $cases -eq 123 ]
do
   password=`head -c $entropy /dev/random | tr -dc a-zA-Z0-9 | tail -c $length`
#The password is made using tr and /dev/random.

   if [ $option -lt 4 ]
   then
       echo $password
       echo ""
   fi
#If the password is less than 4 characters the password is shown without checking that it contains numbers, upper-case and lower-case.

   cases=`echo $password | tr 0-9 1 | tr a-z 2 | tr A-Z 3 | grep -o . | sort -n | uniq | tr -dc 1-3`

#tr replaces 0-9 with 1, a-z with 2 and A-Z with 3.
#grep puts every 1, 2 and 3 on its own line.
#sort sorts the numbers the numbers.
#uniq removes duplicate lines.
#tr removes everything except 1, 2 and 3.
#If the command prints 123 the password contains all cases.

   if [ $cases == 123 ]                     
   then
       echo $password
       echo ""
   fi
#If the password contains upper-case, lower-case and numbers the password is shown.

   if [ $option -lt 4 ]
   then
       cases=123
   fi
#If the password is less than 4 characters, cases are set to 123. This is to exit the loop if the password is short.
done
