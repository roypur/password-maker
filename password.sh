#!/bin/bash
length=$1
entropy=`expr 50 \* $length`
echo -e ""
head -c $entropy /dev/random | tr -dc a-zA-Z0-9 | tail -c $length
echo -e "\n"
