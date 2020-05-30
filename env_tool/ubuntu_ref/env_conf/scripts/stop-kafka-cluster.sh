#!/bin/bash
servers="192.168.0.127 192.168.0.128 192.168.0.129"
KAFKA_HOME="/usr/app/kafka_2.12-2.3.0"
KAFKA_NAME="kafka_2.12-2.3.0"
ZOOKEEPER_HOME="/usr/app/apache-zookeeper-3.5.5"
ZOOKEEPER_NAME="ZOOKEEPER-3.5.5"

echo "INFO : Begin to stop kafka cluster ..."

for broker in $servers
do
  echo "INFO : Shut down ${KAFKA_NAME} on ${broker} ..."
  ssh ${broker} "source /etc/profile;bash ${KAFKA_HOME}/bin/kafka-server-stop.sh"
  if [[ $? -ne 0 ]]; then
      echo "INFO : Shut down ${KAFKA_NAME} on ${broker} is down"
  fi
done

echo "INFO : kafka cluster shut down completed!"