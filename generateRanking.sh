#!/bin/bash
readonly NOCOLOR="\033[0m"
readonly GREEN="\033[0;32m"

case $1 in 
  Chart)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto Chart${NOCOLOR}"
    for (( i = 1; i <= 26; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Chart/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Chart/ "$i"b -ochiai -duas -all -csv ranking/Chart/"$i"b_RankingDuas.csv       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Chart/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Chart/ "$i"b -ochiai -uduas -all -csv ranking/Chart/"$i"b_RankingUDuas.csv
    done
  ;;

  Cli)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto Cli${NOCOLOR}"
    for (( i = 1; i <= 5; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Cli/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Cli/ "$i"b -ochiai -duas -all -csv ranking/Cli/"$i"b_RankingDuas.csv       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Cli/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Cli/ "$i"b -ochiai -uduas -all -csv ranking/Cli/"$i"b_RankingUDuas.csv
    done
    for (( i = 7; i <= 40; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Cli/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Cli/ "$i"b -ochiai -duas -all -csv ranking/Cli/"$i"b_RankingDuas.csv       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Cli/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Cli/ "$i"b -ochiai -uduas -all -csv ranking/Cli/"$i"b_RankingUDuas.csv
    done
  ;;

  Closure)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto Closure${NOCOLOR}"
    for (( i = 1; i <= 62; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Closure/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Closure/ "$i"b -ochiai -duas -all -csv ranking/Closure/"$i"b_RankingDuas.csv       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Closure/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Closure/ "$i"b -ochiai -uduas -all -csv ranking/Closure/"$i"b_RankingUDuas.csv
    done
    for (( i = 64; i <= 92; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Closure/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Closure/ "$i"b -ochiai -duas -all -csv ranking/Closure/"$i"b_RankingDuas.csv       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Closure/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Closure/ "$i"b -ochiai -uduas -all -csv ranking/Closure/"$i"b_RankingUDuas.csv
    done
    for (( i = 94; i <= 176; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Closure/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Closure/ "$i"b -ochiai -duas -all -csv ranking/Closure/"$i"b_RankingDuas.csv       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Closure/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Closure/ "$i"b -ochiai -uduas -all -csv ranking/Closure/"$i"b_RankingUDuas.csv
    done
  ;;

  Codec)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto Codec${NOCOLOR}"
    for (( i = 1; i <= 18; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Codec/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Codec/ "$i"b -ochiai -duas -all -csv ranking/Codec/"$i"b_RankingDuas.csv       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Codec/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Codec/ "$i"b -ochiai -uduas -all -csv ranking/Codec/"$i"b_RankingUDuas.csv
    done
  ;;

  Collections)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto Collections${NOCOLOR}"
    for (( i = 25; i <= 28; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Collections/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Collections/ "$i"b -ochiai -duas -all -csv ranking/Collections/"$i"b_RankingDuas.csv       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Collections/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Collections/ "$i"b -ochiai -uduas -all -csv ranking/Collections/"$i"b_RankingUDuas.csv
    done
  ;;

  Compress)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto Compress${NOCOLOR}"
    for (( i = 1; i <= 47; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Compress/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Compress/ "$i"b -ochiai -duas -all -csv ranking/Compress/"$i"b_RankingDuas.csv       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Compress/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Compress/ "$i"b -ochiai -uduas -all -csv ranking/Compress/"$i"b_RankingUDuas.csv
    done
  ;;

  Csv)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto Csv${NOCOLOR}"
    for (( i = 1; i <= 16; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Csv/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Csv/ "$i"b -ochiai -duas -all -csv ranking/Csv/"$i"b_RankingDuas.csv       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Csv/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Csv/ "$i"b -ochiai -uduas -all -csv ranking/Csv/"$i"b_RankingUDuas.csv
    done
  ;;

  Gson)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto Gson${NOCOLOR}"
    for (( i = 1; i <= 18; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Gson/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Gson/ "$i"b -ochiai -duas -all -Gson ranking/Gson/"$i"b_RankingDuas.Gson       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Gson/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Gson/ "$i"b -ochiai -uduas -all -Gson ranking/Gson/"$i"b_RankingUDuas.Gson
    done
  ;;

  JacksonCore)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto JacksonCore${NOCOLOR}"
    for (( i = 1; i <= 26; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/JacksonCore/"$i"b /PPgSI/df-experiments/dataflow/subsumption/JacksonCore/ "$i"b -ochiai -duas -all -JacksonCore ranking/JacksonCore/"$i"b_RankingDuas.JacksonCore       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/JacksonCore/"$i"b /PPgSI/df-experiments/dataflow/subsumption/JacksonCore/ "$i"b -ochiai -uduas -all -JacksonCore ranking/JacksonCore/"$i"b_RankingUDuas.JacksonCore
    done
  ;;

  JacksonDatabind)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto JacksonDatabind${NOCOLOR}"
    for (( i = 1; i <= 112; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/JacksonDatabind/"$i"b /PPgSI/df-experiments/dataflow/subsumption/JacksonDatabind/ "$i"b -ochiai -duas -all -JacksonDatabind ranking/JacksonDatabind/"$i"b_RankingDuas.JacksonDatabind       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/JacksonDatabind/"$i"b /PPgSI/df-experiments/dataflow/subsumption/JacksonDatabind/ "$i"b -ochiai -uduas -all -JacksonDatabind ranking/JacksonDatabind/"$i"b_RankingUDuas.JacksonDatabind
    done
  ;;

  JacksonXml)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto JacksonXml${NOCOLOR}"
    for (( i = 1; i <= 6; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/JacksonXml/"$i"b /PPgSI/df-experiments/dataflow/subsumption/JacksonXml/ "$i"b -ochiai -duas -all -JacksonXml ranking/JacksonXml/"$i"b_RankingDuas.JacksonXml       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/JacksonXml/"$i"b /PPgSI/df-experiments/dataflow/subsumption/JacksonXml/ "$i"b -ochiai -uduas -all -JacksonXml ranking/JacksonXml/"$i"b_RankingUDuas.JacksonXml
    done
  ;;

  Jsoup)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto Jsoup${NOCOLOR}"
    for (( i = 1; i <= 93; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Jsoup/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Jsoup/ "$i"b -ochiai -duas -all -Jsoup ranking/Jsoup/"$i"b_RankingDuas.Jsoup       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Jsoup/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Jsoup/ "$i"b -ochiai -uduas -all -Jsoup ranking/Jsoup/"$i"b_RankingUDuas.Jsoup
    done
  ;;

  JxPath)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto JxPath${NOCOLOR}"
    for (( i = 1; i <= 22; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/JxPath/"$i"b /PPgSI/df-experiments/dataflow/subsumption/JxPath/ "$i"b -ochiai -duas -all -JxPath ranking/JxPath/"$i"b_RankingDuas.JxPath       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/JxPath/"$i"b /PPgSI/df-experiments/dataflow/subsumption/JxPath/ "$i"b -ochiai -uduas -all -JxPath ranking/JxPath/"$i"b_RankingUDuas.JxPath
    done
  ;;

  Lang)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto Lang${NOCOLOR}"
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Lang/1b /PPgSI/df-experiments/dataflow/subsumption/Lang/ 1b -ochiai -duas -all -Lang ranking/Lang/1b_RankingDuas.Lang       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Lang/1b /PPgSI/df-experiments/dataflow/subsumption/Lang/ 1b -ochiai -uduas -all -Lang ranking/Lang/1b_RankingUDuas.Lang
    for (( i = 3; i <= 65; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Lang/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Lang/ "$i"b -ochiai -duas -all -Lang ranking/Lang/"$i"b_RankingDuas.Lang       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Lang/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Lang/ "$i"b -ochiai -uduas -all -Lang ranking/Lang/"$i"b_RankingUDuas.Lang
    done
  ;;

  Math)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto Math${NOCOLOR}"
    for (( i = 1; i <= 106; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Math/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Math/ "$i"b -ochiai -duas -all -Math ranking/Math/"$i"b_RankingDuas.Math       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Math/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Math/ "$i"b -ochiai -uduas -all -Math ranking/Math/"$i"b_RankingUDuas.Math
    done
  ;;

  Mockito)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto Mockito${NOCOLOR}"
    for (( i = 1; i <= 38; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Mockito/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Mockito/ "$i"b -ochiai -duas -all -Mockito ranking/Mockito/"$i"b_RankingDuas.Mockito       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Mockito/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Mockito/ "$i"b -ochiai -uduas -all -Mockito ranking/Mockito/"$i"b_RankingUDuas.Mockito
    done
  ;;

  Time)
    mkdir -p ranking/$1
    echo -e "${GREEN} Validando projeto Time${NOCOLOR}"
    for (( i = 1; i <= 20; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Time/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Time/ "$i"b -ochiai -duas -all -Time ranking/Time/"$i"b_RankingDuas.Time       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Time/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Time/ "$i"b -ochiai -uduas -all -Time ranking/Time/"$i"b_RankingUDuas.Time
    done
    for (( i = 22; i <= 27; i++ ))
    do
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Time/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Time/ "$i"b -ochiai -duas -all -Time ranking/Time/"$i"b_RankingDuas.Time       
      ./faultdetectv3.py /PPgSI/df-experiments/dataflow/coverage/Time/"$i"b /PPgSI/df-experiments/dataflow/subsumption/Time/ "$i"b -ochiai -uduas -all -Time ranking/Time/"$i"b_RankingUDuas.Time

    done
  ;;

  *)
    echo -e "\nPlease use valid defects4j project parameters:\n"
    echo -e "Accepted values: Chart Cli Closure Codec Collections Compress Csv Gson JacksonCore JacksonDatabind JacksonXml Jsoup JxPath Lang Math Mockito Time\n\n"
    ;;

esac



