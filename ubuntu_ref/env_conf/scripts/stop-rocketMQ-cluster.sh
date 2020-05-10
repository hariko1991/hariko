#!/bin/bash
servers="192.168.0.127 192.168.0.128 192.168.0.129"
masters=("broker-a" "broker-b" "broker-c")
slaves=("broker-c-s" "broker-a-s" "broker-b-s")
ROCKET_MQ_HOME="/usr/app/rocketmq-4.5.0"
ROCKET_MQ_CONF="/usr/app/rocketmq-4.5.0/conf/hariko-2m-2s-async/"
ROCKET_MQ_NAME="rocketmq-4.5.0"

echo "INFO : Begin to stop rocketMQ cluster ..."

for broker in $servers
do
  echo "INFO : Stoping broker and namesrv on ${broker} ..."
  
  ssh root@${broker} "source /etc/profile; sh ${ROCKET_MQ_HOME}/bin/mqshutdown broker; sh ${ROCKET_MQ_HOME}/bin/mqshutdown namesrv;"
  echo "INFO:broker and namesrv on [${broker}] stop result $?"
  if [[ $? -eq 0 ]]; then
      echo "INFO:broker and namesrv on [${broker}] Stop successfully"
  fi
  
done
echo "INFO:rocketMQ cluster stops successfully !"