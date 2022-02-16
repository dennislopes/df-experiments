#!/usr/bin/env bash

readonly NOCOLOR="\033[0m"
readonly GREEN="\033[0;32m"
readonly RED="\033[0;31m"
readonly YELLOW="\033[1;33m"
readonly BLUE="\033[0;34m"       
readonly PURPLE="\033[0;35m"       
readonly CYAN="\033[0;36m"         

echo -e "\n${CYAN} Setting TZ variable in order to run Chart tests ${NOCOLOR}"
export TZ=America/Los_Angeles

export PROJECT_ROOT_DIR="/PPgSI/workdir"
export RESULTS_DIR="/PPgSI/df-experiments/classes"
export PATH="$PATH:/PPgSI/defects4j/framework/bin"
export PROJECT_DIR="$PROJECT_ROOT_DIR/$1/$2"
export BADUA_AGENT="/PPgSI/ba-dua/ba-dua-agent-rt/target/ba-dua-agent-rt-0.4.1-SNAPSHOT-all.jar"
export BADUA_JAR="/PPgSI/ba-dua/ba-dua-cli/target/ba-dua-cli-0.4.1-SNAPSHOT-all.jar"
export JAGUAR_JAR="/PPgSI/jaguar-df/target/jaguar-df-0.1-SNAPSHOT-jar-with-dependencies.jar"
export JAGUAR_MAIN_CLASS="br.usp.each.saeg.jaguardf.cli.JaguarRunner"
export LOG_LEVEL="TRACE"
export OUTPUT_DIR="report/df"
export JUNIT_JAR="/PPgSI/df-experiments/lib/junit-4.13.2.jar"
export HAMCREST="/PPgSI/df-experiments/lib/hamcrest-core-1.3.jar"
export JUNIT_CLASS="org.junit.runner.JUnitCore"

echo -e "\n${YELLOW} Criando o diretorio e baixando o codigo${NOCOLOR}"
rm -fr $PROJECT_DIR
rm -fr $RESULTS_DIR/$1/$2
mkdir -p $PROJECT_ROOT_DIR/$1
mkdir -p $PROJECT_DIR
mkdir -p $RESULTS_DIR/$1
mkdir -p $RESULTS_DIR/$1/$2
mkdir -p $RESULTS_DIR/$1/$2/relevant
mkdir -p $RESULTS_DIR/$1/$2/modified
cd $PROJECT_DIR
defects4j checkout -p $1 -v $2 -w $PROJECT_DIR

echo -e "\n${YELLOW} Compilando o codigo ${NOCOLOR}"
defects4j compile

echo -e "\n${YELLOW} Coletando classes relevantes ${NOCOLOR}"
sourcedir="$(defects4j export -p dir.src.classes | sed 's/\//./g')".
defects4j export -p classes.modified > classes.modified
defects4j export -p classes.relevant > classes.relevant
sed -i "s/^/$sourcedir/" classes.relevant
sed -i "s/^/$sourcedir/" classes.modified
sed -i 's/\./\//g' classes.relevant
sed -i 's/\./\//g' classes.modified

mkdir -p modified
mkdir -p relevant

file=classes.relevant
while IFS= read -r line || [ -n "$line" ];
do
	cp $line.java relevant 
done <"$file"

file=classes.modified
while IFS= read -r line || [ -n "$line" ];
do
	cp $line.java modified 
done <"$file"

cp -r modified/* /$RESULTS_DIR/$1/$2/modified
cp -r relevant/* /$RESULTS_DIR/$1/$2/relevant

cp classes.relevant /$RESULTS_DIR/$1/$2/
cp classes.modified /$RESULTS_DIR/$1/$2/

rm -fr $PROJECT_ROOT_DIR/$1/$2

