#!/bin/bash
servers="192.168.0.127 192.168.0.128 192.168.0.129"
KAFKA_HOME="/usr/app/kafka_2.12-2.3.0"
KAFKA_NAME="kafka_2.12-2.3.0"
ZOOKEEPER_HOME="/usr/app/apache-zookeeper-3.5.5"
ZOOKEEPER_NAME="ZOOKEEPER-3.5.5"

echo "INFO : Begin to start kafka cluster ..."

for broker in $servers
do
  echo "INFO : Starting ${KAFKA_NAME} on ${broker} ..."
  ssh ${broker} -C "source /etc/profile; sh ${KAFKA_HOME}/bin/kafka-server-start.sh -daemon ${KAFKA_HOME}/config/server.properties"
  if [[ $? -eq 0 ]]; then
      echo "INFO:kafka [${broker}] Start successfully"
  fi
done
echo "INFO:Kafka cluster starts successfully !"