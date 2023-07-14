#!/bin/bash

PWD=`pwd`
for i in ./lib/*;
do CLASSPATH=$PWD/$i:"$CLASSPATH";
done

ANSI_RED='\033[0;31m'
ANSI_RESET='\033[0m'

export JAVA_HOME=$(/usr/libexec/java_home -v 20)
export PATH="$JAVA_HOME/bin:$PATH"
export SPARK_HOME='/opt/homebrew/Cellar/apache-spark/3.4.1'
export HADOOP_CONF_DIR='/opt/homebrew/Cellar/hadoop/3.3.6/libexec/etc/hadoop'
export YARN_CONF_DIR='/opt/homebrew/Cellar/hadoop/3.3.6/libexec/etc/hadoop'
export CLASSPATH=".:./conf:${HADOOP_CONF_DIR}:${YARN_CONF_DIR}:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$CLASSPATH"
export HADOOP_HOME="/opt/homebrew/Cellar/hadoop/3.3.6"
export HADOOP_COMMON_HOME=${HADOOP_HOME}
export HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_HOME}/lib/native
export HADOOP_USER_NAME=zhengjiaye



echo "parameters: "$*

java -cp $CLASSPATH sics.seiois.mlsserver.service.impl.RuleFinder $*

echo "${ANSI_RED}End Of Java Application. Exit with code: $? ${ANSI_RESET}"
