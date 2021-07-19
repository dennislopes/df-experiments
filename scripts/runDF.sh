#!/usr/bin/env bash

readonly NOCOLOR="\033[0m"
readonly GREEN="\033[0;32m"
readonly RED="\033[0;31m"
readonly YELLOW="\033[1;33m"

export PROJECT_ROOT_DIR="/PPgSI/workdir"
export RESULTS_DIR="/PPgSI/results"
export PATH="$PATH:/PPgSI/defects4j/framework/bin"
export PROJECT_DIR="$PROJECT_ROOT_DIR/$1/$2"
export BADUA_AGENT="/PPgSI/ba-dua/ba-dua-agent-rt/target/ba-dua-agent-rt-0.4.1-SNAPSHOT-all.jar"
export BADUA_JAR="/PPgSI/ba-dua/ba-dua-cli/target/ba-dua-cli-0.4.1-SNAPSHOT-all.jar"
export JAGUAR_JAR="/PPgSI/jaguar-df/target/jaguar-df-0.1-SNAPSHOT-jar-with-dependencies.jar"
export JAGUAR_MAIN_CLASS="br.usp.each.saeg.jaguardf.cli.JaguarRunner"
export LOG_LEVEL="TRACE"
export OUTPUT_DIR="report/df"
export JUNIT_JAR="/PPgSI/defects4j/major/lib/junit-4.11.jar"
export JUNIT_CLASS="org.junit.runner.JUnitCore"

echo -e "${YELLOW} Criando o diretório e baixando o código ${NOCOLOR}"
rm -fr $PROJECT_DIR
mkdir $PROJECT_ROOT_DIR/$1
mkdir $PROJECT_DIR
mkdir $RESULTS_DIR/$1
mkdir $RESULTS_DIR/$1/$2
cd $PROJECT_DIR
defects4j checkout -p $1 -v $2 -w $PROJECT_DIR

echo -e "${YELLOW} Compilando o código ${NOCOLOR}"
defects4j compile

echo -e "${YELLOW} Testando o código ${NOCOLOR}"
defects4j test > $PROJECT_ROOT_DIR/$1/$2/defects4j.out

echo -e "${YELLOW} Exportando CLASSPATH e conjunto de testes ${NOCOLOR}"
export CLASSPATH="$(defects4j export -p cp.test -w $PROJECT_DIR)"
export TESTS="$(defects4j export -p tests.all -w $PROJECT_DIR | tr "\n" " " | awk '{$1=$1};1')"
export CLASSES_DIR="$(defects4j export -p dir.bin.classes -w $PROJECT_DIR)"
export TESTS_DIR="$(defects4j export -p dir.bin.tests -w $PROJECT_DIR)"
defects4j export -p tests.all -w $PROJECT_DIR > tests.all

echo -e "${RED} Executando os testes com a Ba-dua${NOCOLOR}"
java -javaagent:$BADUA_AGENT \
			-cp $CLASSPATH:$JUNIT_JAR \
			$JUNIT_CLASS $TESTS | tee $PROJECT_ROOT_DIR/$1/$2/ba-dua.out
			
echo -e "${RED} Gerando relatorio da Ba-dua ${NOCOLOR}"
java -jar $BADUA_JAR report \
	-show-classes \
	-input coverage.ser \
	-classes $CLASSES_DIR \
	-xml $PROJECT_ROOT_DIR/$1/$2/ba-dua.xml
	
echo -e "${RED} Gerando relatorio da Ba-dua (pretty print) ${NOCOLOR}"
xmllint --format $PROJECT_ROOT_DIR/$1/$2/ba-dua.xml --output $PROJECT_ROOT_DIR/$1/$2/ba-dua.xml
rm coverage.ser
echo -e "${RED} Copiando resultados ${NOCOLOR}"
cp ba-dua.xml ba-dua.out defects4j.out /$RESULTS_DIR/$1/$2/

echo -e "${GREEN} executando a jaguar${NOCOLOR}"
(time java -javaagent:$BADUA_AGENT \
    -Dbadua.experimental.exception_handler=true \
    -cp $CLASSPATH:$JAGUAR_JAR:$BADUA_AGENT \
	$JAGUAR_MAIN_CLASS \
	--projectDir $PROJECT_DIR \
	--classesDir $CLASSES_DIR \
	--testsDir  $TESTS_DIR \
	--tests $PROJECT_DIR/tests.all \
	--logLevel "INFO")b | tee $PROJECT_ROOT_DIR/$1/$2/jaguar.out

cp jaguar.out /$RESULTS_DIR/$1/$2/
cp -r .jaguar/* /$RESULTS_DIR/$1/$2/

echo -e "${GREEN} Gerando relatorio da Ba-dua ${NOCOLOR}"
java -jar $BADUA_JAR report \
	-show-classes \
	-input coverage.ser \
	-classes $CLASSES_DIR \
	-xml $PROJECT_ROOT_DIR/$1/$2/ba-dua_jaguar.xml
	
echo -e "${GREEN} Gerando relatorio da Ba-dua (pretty print) ${NOCOLOR}"
xmllint --format $PROJECT_ROOT_DIR/$1/$2/ba-dua_jaguar.xml --output $PROJECT_ROOT_DIR/$1/$2/ba-dua_jaguar.xml
cp ba-dua_jaguar.xml /$RESULTS_DIR/$1/$2/
