#!/bin/bash
readonly NOCOLOR="\033[0m"
readonly GREEN="\033[0;32m"

echo -e "${GREEN} Validando projeto Csv${NOCOLOR}"
for (( i = 1; i <= 16; i++ ))
do
./runDF.sh Csv "$i"b $1
done
