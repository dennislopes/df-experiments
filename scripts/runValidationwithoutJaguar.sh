#!/bin/bash
readonly NOCOLOR="\033[0m"
readonly GREEN="\033[0;32m"

echo -e "${GREEN} Validando projeto Collections${NOCOLOR}"
for (( i = 25; i <= 28; i++ ))
do
./runDFwithoutJaguar.sh Collections "$i"b
done

echo -e "${GREEN} Validando projeto Chart${NOCOLOR}"
for (( i = 1; i <= 26; i++ ))
do
./runDFwithoutJaguar.sh Chart "$i"b
done

echo -e "${GREEN} Validando projeto Compress${NOCOLOR}"
for (( i = 1; i <= 47; i++ ))
do
./runDFwithoutJaguar.sh Compress "$i"b
done

echo -e "${GREEN} Validando projeto Math${NOCOLOR}"
for (( i = 1; i <= 106; i++ ))
do
./runDFwithoutJaguar.sh Math "$i"b
done

echo -e "${GREEN} Validando projeto Time${NOCOLOR}"
for (( i = 1; i <= 20; i++ ))
do
./runDFwithoutJaguar.sh Time "$i"b
done
for (( i = 22; i <= 27; i++ ))
do
./runDFwithoutJaguar.sh Time "$i"b
done

echo -e "${GREEN} Validando projeto Cli${NOCOLOR}"
for (( i = 1; i <= 5; i++ ))
do
./runDFwithoutJaguar.sh Cli "$i"b
done
for (( i = 7; i <= 40; i++ ))
do
./runDFwithoutJaguar.sh Cli "$i"b
done

echo -e "${GREEN} Validando projeto Closure${NOCOLOR}"
for (( i = 1; i <= 62; i++ ))
do
./runDFwithoutJaguar.sh Closure "$i"b
done
for (( i = 64; i <= 92; i++ ))
do
./runDFwithoutJaguar.sh Closure "$i"b
done
for (( i = 94; i <= 176; i++ ))
do
./runDFwithoutJaguar.sh Closure "$i"b
done

echo -e "${GREEN} Validando projeto Codec${NOCOLOR}"
for (( i = 1; i <= 18; i++ ))
do
./runDFwithoutJaguar.sh Codec "$i"b
done

echo -e "${GREEN} Validando projeto Csv${NOCOLOR}"
for (( i = 1; i <= 16; i++ ))
do
./runDFwithoutJaguar.sh Csv "$i"b
done

echo -e "${GREEN} Validando projeto Gson${NOCOLOR}"
for (( i = 1; i <= 18; i++ ))
do
./runDFwithoutJaguar.sh Gson "$i"b
done

echo -e "${GREEN} Validando projeto JacksonCore${NOCOLOR}"
for (( i = 1; i <= 26; i++ ))
do
./runDFwithoutJaguar.sh JacksonCore "$i"b
done

echo -e "${GREEN} Validando projeto JacksonDatabind${NOCOLOR}"
for (( i = 1; i <= 112; i++ ))
do
./runDFwithoutJaguar.sh JacksonDatabind "$i"b
done

echo -e "${GREEN} Validando projeto JacksonXml${NOCOLOR}"
for (( i = 1; i <= 6; i++ ))
do
./runDFwithoutJaguar.sh JacksonXml "$i"b
done

echo -e "${GREEN} Validando projeto Jsoup${NOCOLOR}"
for (( i = 1; i <= 93; i++ ))
do
./runDFwithoutJaguar.sh Jsoup "$i"b
done

echo -e "${GREEN} Validando projeto JxPath${NOCOLOR}"
for (( i = 1; i <= 22; i++ ))
do
./runDFwithoutJaguar.sh JxPath "$i"b
done

echo -e "${GREEN} Validando projeto Lang${NOCOLOR}"
./runDFwithoutJaguar.sh Lang 1b
for (( i = 3; i <= 65; i++ ))
do
./runDFwithoutJaguar.sh Lang "$i"b
done

echo -e "${GREEN} Validando projeto Mockito${NOCOLOR}"
for (( i = 1; i <= 38; i++ ))
do
./runDFwithoutJaguar.sh Mockito "$i"b
done
