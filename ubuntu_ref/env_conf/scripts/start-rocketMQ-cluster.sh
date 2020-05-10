#!/bin/bash
servers=("192.168.0.127" "192.168.0.128" "192.168.0.129")
masters=("broker-a" "broker-b" "broker-c")
slaves=("broker-c-s" "broker-a-s" "broker-b-s")
ROCKET_MQ_HOME="/usr/app/rocketmq-4.5.0"
ROCKET_MQ_CONF="/usr/app/rocketmq-4.5.0/conf/hariko-2m-2s-async/"
ROCKET_MQ_NAME="rocketmq-4.5.0"
JAVA_HOME="/usr/java/jdk1.8.0_201"

export JAVA_HOME

echo "INFO : Begin to start rocketMQ cluster ..."

for((i=0;i<3;i++)) do
  broker=${servers[i]}
  master=${masters[i]}
  slave=${slaves[i]}

  echo "INFO : Starting namesrv on ${broker} ..."
  #ssh ${broker} -C "source /etc/profile; sh ${ROCKET_MQ_HOME}/bin/mqnamesrv -daemon"
  
  ssh root@${broker} "source /etc/profile; nohup sh ${ROCKET_MQ_HOME}/bin/mqnamesrv;"
  echo "INFO:namesrv on [${broker}] Start result $?"
  
  echo "INFO : Starting broker master on ${broker} ..."
  #ssh ${broker} -C "source /etc/profile; sh ${ROCKET_MQ_HOME}/bin/mqbroker -c ${ROCKET_MQ_CONF}/${master}.properties -daemon"
  
  ssh root@${broker} "source /etc/profile; nohup sh ${ROCKET_MQ_HOME}/bin/mqbroker -c ${ROCKET_MQ_CONF}/${master}.properties;"
  echo "INFO:broker master [${broker}] Start result $?"
  
  echo "INFO : Starting broker slave on ${broker} ..."
  #ssh ${broker} -C "source /etc/profile; sh ${ROCKET_MQ_HOME}/bin/mqbroker -c ${ROCKET_MQ_CONF}/${slave}.properties -daemon"
  
  ssh root@${broker} "source /etc/profile; nohup sh ${ROCKET_MQ_HOME}/bin/mqbroker -c ${ROCKET_MQ_CONF}/${slave}.properties;"
  echo "INFO:broker slave on [${broker}] Start result $?"

done
echo "INFO:rocketMQ cluster starts successfully !"