#!/bin/bash

option=${1-20}

cas=`echo $option | tr -dc a-c`
casa=`echo $cas 2 | tr a 1 | tr -dc 12 | grep -o . | sort -n | uniq | tr -dc 12 | head -c 1`
casb=`echo $cas 2 | tr b 1 | tr -dc 12 | grep -o . | sort -n | uniq | tr -dc 12 | head -c 1`
casc=`echo $cas 2 | tr c 1 | tr -dc 12 | grep -o . | sort -n | uniq | tr -dc 12 | head -c 1`

toption=`echo $option | tr -dc 0-9`
toption=`echo a $toption | tr 0-9 1 | tr a 2 | tr -dc 12 | grep -o . | sort -n | uniq | tr -dc 12 | head -c 1`

passcas=`echo a-zA-Z0-9`


if [ $toption -eq 1 ]
then
    length=`echo $option | tr -dc 0-9`
fi

if [ $toption -eq 2 ]
then
    length=20
fi


if [ $casa -eq 1 ]
then
    cas1=a-z
fi

if [ $casb -eq 1 ]
then
    cas2=A-Z
fi

if [ $casc -eq 1 ]
then
    cas3=0-9
fi


if [ $casa -eq 1 ]
then
    passcas=`echo $cas1 $cas2 $cas3 | tr -dc a-zA-Z0-9-`
fi

if [ $casb -eq 1 ]
then
    passcas=`echo $cas1 $cas2 $cas3 | tr -dc a-zA-Z0-9-`
fi

if [ $casc -eq 1 ]
then
    passcas=`echo $cas1 $cas2 $cas3 | tr -dc a-zA-Z0-9-`
fi

#passcas is the characters the password should contain.

casenumber=`echo $passcas | tr 0-9 1 | tr a-z 2 | tr A-Z 3 | grep -o . | sort -n | uniq | tr -dc 1-3`

#casenumber is a numerical value representing the characters in the password. a-z is 1, A-Z is 2 and 0-9 is 3.


entropy=`expr 50 \* $length`
echo ""

cases=5
#The cases variable is set to 5 to avoid errors beccause cases doesent exist. Any numerical value except 123 will do.


until [ $cases -eq $casenumber ]
do
   password=`head -c $entropy /dev/random | tr -dc $passcas | tail -c $length`


#The password is made using tr and /dev/random.

   if [ $length -lt 3 ]
   then
       echo $password
       echo ""
   fi
#If the password is less than 3 characters the password is shown without checking that it contains numbers, upper-case and lower-case.

   cases=`echo $password | tr 0-9 1 | tr a-z 2 | tr A-Z 3 | grep -o . | sort -n | uniq | tr -dc 1-3`

#tr replaces 0-9 with 1, a-z with 2 and A-Z with 3.
#grep puts every 1, 2 and 3 on its own line.
#sort sorts the numbers the numbers.
#uniq removes duplicate lines.
#tr removes everything except 1, 2 and 3.


   if [ $length -gt 3 ]
   then
       if [ $cases == $casenumber ]
       then
           echo $password
           echo ""
       fi
   fi
#If the password contains upper-case, lower-case and numbers the password is shown.


   if [ $length -lt 3 ]
   then
       cases=`echo $casenumber`
   fi
#If the password is less than 3 characters, cases are set to the same as the passcas variable. This is to exit the loop if the password is short.
done

#The until statement keeps the script running until the password contains the specified characters.
#If no characters are specified it keeps running until it contains upper-case, lower-case and numbers.
