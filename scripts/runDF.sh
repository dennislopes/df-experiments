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
export RESULTS_DIR="/PPgSI/results"
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

echo -e "\n${YELLOW} Criando o diretório e baixando o códig ${NOCOLOR}"
rm -fr $PROJECT_DIR
mkdir -p $PROJECT_ROOT_DIR/$1
mkdir -p $PROJECT_DIR
mkdir -p $RESULTS_DIR/$1
mkdir -p $RESULTS_DIR/$1/$2
cd $PROJECT_DIR
defects4j checkout -p $1 -v $2 -w $PROJECT_DIR

echo -e "\n${YELLOW} Compilando o código ${NOCOLOR}"
defects4j compile

echo -e "\n${YELLOW} Exportando CLASSPATH e conjunto de testes ${NOCOLOR}"
export CLASSPATH="$(defects4j export -p cp.test -w $PROJECT_DIR)"
export TESTS="$(defects4j export -p tests.all -w $PROJECT_DIR | tr "\n" " " | awk '{$1=$1};1')"
export CLASSES_DIR="$(defects4j export -p dir.bin.classes -w $PROJECT_DIR)"
export TESTS_DIR="$(defects4j export -p dir.bin.tests -w $PROJECT_DIR)"
#defects4j export -p tests.all -w $PROJECT_DIR > tests.all

echo -e "\n${BLUE} Testando o código com o jUnit ${NOCOLOR}"
java -cp .:$CLASSPATH:$JUNIT_JAR:$HAMCREST $JUNIT_CLASS $TESTS | tee $PROJECT_ROOT_DIR/$1/$2/junit.out

echo -e "\n${YELLOW} Testando o código com o Defect4J  ${NOCOLOR}"
defects4j test > $PROJECT_ROOT_DIR/$1/$2/defects4j.out

echo -e "\n${RED} Executando os testes com a Ba-dua${NOCOLOR}"
java -javaagent:$BADUA_AGENT \
    			-Dbadua.experimental.exception_handler=true \
			-cp $CLASSPATH:$JUNIT_JAR:$HAMCREST \
			$JUNIT_CLASS $TESTS | tee $PROJECT_ROOT_DIR/$1/$2/ba-dua.out
			
echo -e "\n${RED} Gerando relatorio da Ba-dua ${NOCOLOR}"
java -jar $BADUA_JAR report \
	-show-classes \
	-input coverage.ser \
	-classes $CLASSES_DIR \
	-xml $PROJECT_ROOT_DIR/$1/$2/ba-dua.xml
	
echo -e "\n${RED} Gerando relatorio da Ba-dua (pretty print) ${NOCOLOR}"
xmllint --format $PROJECT_ROOT_DIR/$1/$2/ba-dua.xml --output $PROJECT_ROOT_DIR/$1/$2/ba-dua.xml
rm coverage.ser
echo -e "\n${RED} Copiando resultados ${NOCOLOR}"
cp ba-dua.xml ba-dua.out defects4j.out junit.out /$RESULTS_DIR/$1/$2/

echo -e "\n${GREEN} Executando a jaguar${NOCOLOR}"
(time java -javaagent:$BADUA_AGENT \
    -Dbadua.experimental.exception_handler=true \
    -cp $CLASSPATH:$JAGUAR_JAR:$BADUA_AGENT \
	$JAGUAR_MAIN_CLASS \
	--projectDir $PROJECT_DIR \
	--classesDir $CLASSES_DIR \
	--testsDir  $TESTS_DIR \
	--tests $PROJECT_DIR/tests.all \
	--logLevel "INFO") | tee $PROJECT_ROOT_DIR/$1/$2/jaguar.out

cp jaguar.out /$RESULTS_DIR/$1/$2/
cp -r .jaguar/* /$RESULTS_DIR/$1/$2/

echo -e "\n${GREEN} Gerando relatorio da Ba-dua ${NOCOLOR}"
java -jar $BADUA_JAR report \
	-show-classes \
	-input coverage.ser \
	-classes $CLASSES_DIR \
	-xml $PROJECT_ROOT_DIR/$1/$2/ba-dua_jaguar.xml
	
echo -e "\n${GREEN} Gerando relatorio da Ba-dua (pretty print) ${NOCOLOR}"
xmllint --format $PROJECT_ROOT_DIR/$1/$2/ba-dua_jaguar.xml --output $PROJECT_ROOT_DIR/$1/$2/ba-dua_jaguar.xml
cp ba-dua_jaguar.xml /$RESULTS_DIR/$1/$2/

echo -e "\n${PURPLE} \n Gerando relatório de falhas (${BLUE}jUNIT ${YELLOW}Defects4J ${RED}Ba-dua ${GREEN}Jaguar${NOCOLOR})"

python /PPgSI/df-experiments/scripts/getFailingTests.py | tee $PROJECT_ROOT_DIR/$1/$2/FailingTests.out

echo "######################################################" >> $RESULTS_DIR/$1-MainReport.out
echo "##### PROJETO.....: $1" >> $RESULTS_DIR/$1-MainReport.out
echo "##### VERSAO......: $2" >> $RESULTS_DIR/$1-MainReport.out
echo "######################################################" >> $RESULTS_DIR/$1-MainReport.out
cat $PROJECT_ROOT_DIR/$1/$2/FailingTests.out >> $RESULTS_DIR/$1-MainReport.out
