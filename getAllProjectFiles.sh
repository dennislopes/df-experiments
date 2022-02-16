#!/bin/bash
readonly NOCOLOR="\033[0m"
readonly GREEN="\033[0;32m"

#echo -e "${GREEN} Validando projeto Chart${NOCOLOR}"

for (( i = 1; i <= 26; i++ ))
do
./getFiles.sh Chart "$i"b
./get_buggy_lines.sh Chart "$i" /PPgSI/df-experiments/buggyLines/Chart
done

#echo -e "${GREEN} Validando projeto Cli${NOCOLOR}"

for (( i = 1; i <= 5; i++ ))
do
./getFiles.sh Cli "$i"b
./get_buggy_lines.sh Cli "$i" /PPgSI/df-experiments/buggyLines/Cli
done

for (( i = 7; i <= 40; i++ ))
do
./getFiles.sh Cli "$i"b
./get_buggy_lines.sh Cli "$i" /PPgSI/df-experiments/buggyLines/Cli
done

#echo -e "${GREEN} Validando projeto Closure${NOCOLOR}"

for (( i = 1; i <= 62; i++ ))
do
./getFiles.sh Closure "$i"b
./get_buggy_lines.sh Closure "$i" /PPgSI/df-experiments/buggyLines/Closure
done

for (( i = 64; i <= 92; i++ ))
do
./getFiles.sh Closure "$i"b
./get_buggy_lines.sh Closure "$i" /PPgSI/df-experiments/buggyLines/Closure
done

for (( i = 94; i <= 176; i++ ))
do
./getFiles.sh Closure "$i"b
./get_buggy_lines.sh Closure "$i" /PPgSI/df-experiments/buggyLines/Closure
done

#echo -e "${GREEN} Validando projeto Codec${NOCOLOR}"

for (( i = 1; i <= 18; i++ ))
do
./getFiles.sh Codec "$i"b
./get_buggy_lines.sh Codec "$i" /PPgSI/df-experiments/buggyLines/Codec
done

#echo -e "${GREEN} Validando projeto Collections${NOCOLOR}"

for (( i = 25; i <= 28; i++ ))
do
./getFiles.sh Collections "$i"b
./get_buggy_lines.sh Collections "$i" /PPgSI/df-experiments/buggyLines/Collections
done

#echo -e "${GREEN} Validando projeto Compress${NOCOLOR}"

for (( i = 1; i <= 47; i++ ))
do
./getFiles.sh Compress "$i"b
./get_buggy_lines.sh Compress "$i" /PPgSI/df-experiments/buggyLines/Compress
done

#echo -e "${GREEN} Validando projeto Csv${NOCOLOR}"

for (( i = 1; i <= 16; i++ ))
do
./getFiles.sh Csv "$i"b
./get_buggy_lines.sh Csv "$i" /PPgSI/df-experiments/buggyLines/Csv
done

#echo -e "${GREEN} Validando projeto Gson${NOCOLOR}"

for (( i = 1; i <= 18; i++ ))
do
./getFiles.sh Gson "$i"b
./get_buggy_lines.sh Gson "$i" /PPgSI/df-experiments/buggyLines/Gson
done

#echo -e "${GREEN} Validando projeto JacksonCore${NOCOLOR}"

for (( i = 1; i <= 26; i++ ))
do
./getFiles.sh JacksonCore "$i"b
./get_buggy_lines.sh JacksonCore "$i" /PPgSI/df-experiments/buggyLines/JacksonCore
done

#echo -e "${GREEN} Validando projeto JacksonDatabind${NOCOLOR}"

for (( i = 1; i <= 112; i++ ))
do
./getFiles.sh JacksonDatabind "$i"b
./get_buggy_lines.sh JacksonDatabind "$i" /PPgSI/df-experiments/buggyLines/JacksonDatabind
done

#echo -e "${GREEN} Validando projeto JacksonXml${NOCOLOR}"

for (( i = 1; i <= 6; i++ ))
do
./getFiles.sh JacksonXml "$i"b
./get_buggy_lines.sh JacksonXml "$i" /PPgSI/df-experiments/buggyLines/JacksonXml
done

#echo -e "${GREEN} Validando projeto Jsoup${NOCOLOR}"

for (( i = 1; i <= 93; i++ ))
do
./getFiles.sh Jsoup "$i"b
./get_buggy_lines.sh Jsoup "$i" /PPgSI/df-experiments/buggyLines/Jsoup
done

#echo -e "${GREEN} Validando projeto JxPath${NOCOLOR}"

for (( i = 1; i <= 22; i++ ))
do
./getFiles.sh JxPath "$i"b
./get_buggy_lines.sh JxPath "$i" /PPgSI/df-experiments/buggyLines/JxPath
done

#echo -e "${GREEN} Validando projeto Lang${NOCOLOR}"

./getFiles.sh Lang 1b
./get_buggy_lines.sh Lang 1 /PPgSI/df-experiments/buggyLines/Lang

for (( i = 3; i <= 65; i++ ))
do
./getFiles.sh Lang "$i"b
./get_buggy_lines.sh Lang "$i" /PPgSI/df-experiments/buggyLines/Lang
done

#echo -e "${GREEN} Validando projeto Math${NOCOLOR}"

for (( i = 1; i <= 106; i++ ))
do
./getFiles.sh Math "$i"b
./get_buggy_lines.sh Math "$i" /PPgSI/df-experiments/buggyLines/Math
done

#echo -e "${GREEN} Validando projeto Mockito${NOCOLOR}"

for (( i = 1; i <= 38; i++ ))
do
./getFiles.sh Mockito "$i"b
./get_buggy_lines.sh Mockito "$i" /PPgSI/df-experiments/buggyLines/Mockito
done

#echo -e "${GREEN} Validando projeto Time${NOCOLOR}"

for (( i = 1; i <= 20; i++ ))
do
./getFiles.sh Time "$i"b
./get_buggy_lines.sh Time "$i" /PPgSI/df-experiments/buggyLines/Time
done

for (( i = 22; i <= 27; i++ ))
do
./getFiles.sh Time "$i"b
./get_buggy_lines.sh Time "$i" /PPgSI/df-experiments/buggyLines/Time
done








