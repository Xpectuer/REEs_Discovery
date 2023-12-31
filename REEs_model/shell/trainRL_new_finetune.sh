#!/bin/bash

PWD=`pwd`
for i in ../lib/*;
do CLASSPATH=$PWD/$i:"$CLASSPATH";
done


export JAVA_HOME='/opt/jdk1.8.0_231/'
export PATH="$JAVA_HOME/bin:$PATH"
export SPARK_HOME='/usr/hdp/3.1.0.0-78/spark2'
export CLASSPATH="..:../conf:/etc/hadoop/conf:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$CLASSPATH"
export CLASSPATH="/opt/disk1/yaoshuw/discovery/trainDQN/calculateConf.jar:$CLASSPATH"


#/root/anaconda3/bin/python3 test.py -classpath ${CLASSPATH}


task=(
"adults"
"airports"
"flight"
"hospital"
"inspection"
"ncvoter"
"aminer"
"tax100w"
"tax200w"
"tax400w"
"tax600w"
"tax800w"
"tax1000w"
"property"
)

tid=$1
#tid=5
epoch=200
combine_num=90

data_path="/opt/disk1/yaoshuw/discovery/Sampling/originalData/"${task[${tid}]}"/"
#data_path="/opt/disk1/yaoshuw/discovery/Sampling/DQN/"${task[${tid}]}'/'
constant_path="/opt/disk1/yaoshuw/discovery/generateConPreEQ/constantRresults/constant_"${task[${tid}]}".txt"
predicates_path="/opt/disk1/yaoshuw/discovery/trainDQN/all_predicates/"${task[${tid}]}"_predicates.txt"
model_dir='/opt/disk1/yaoshuw/discovery/trainDQN/dqn_model/'${task[${tid}]}$'/'

mkdir '/opt/disk1/yaoshuw/discovery/trainDQN/dqn_model'
mkdir ${model_dir}
model_path=${model_dir}'model.ckpt'

filter_model_dir='/opt/disk1/yaoshuw/discovery/trainDQN/filter_model/'${task[${tid}]}'/'

mkdir '/opt/disk1/yaoshuw/discovery/trainDQN/filter_model'
mkdir ${filter_model_dir}
filter_model_path=${filter_model_dir}'model.txt'


filter_data_dir='/opt/disk1/yaoshuw/discovery/trainDQN/filter_data/'${task[${tid}]}'/'
mkdir '/opt/disk1/yaoshuw/discovery/trainDQN/filter_data/'
mkdir ${filter_data_dir}

#/root/anaconda3/bin/python3 REEs_model/PredicateComsFilter/RL_confidence_main.py -classpath ${CLASSPATH} -directory_path ${data_path} -constant_file ${constant_path} -epoch ${epoch} -predicates_path ${predicates_path} -model_path ${model_path}

# process...
/root/anaconda3/bin/python3 REEs_model/PredicateComsFilter/Filter_generate_data_main.py -classpath ${CLASSPATH} -directory_path ${data_path} -constant_file ${constant_path} -epoch ${epoch} -predicates_path ${predicates_path} -dqn_model_path ${model_path} -model_path ${filter_model_path} -filter_dir ${filter_data_dir} -combine_num ${combine_num}

/root/anaconda3/bin/python3 REEs_model/PredicateComsFilter/Filter_classifier_main.py -epoch ${epoch} -model_path ${filter_model_path} -filter_dir ${filter_data_dir}
