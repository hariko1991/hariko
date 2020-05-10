#!/bin/bash
servers="192.168.0.127 192.168.0.128 192.168.0.129"
KAFKA_HOME="/usr/app/kafka_2.12-2.3.0"
KAFKA_NAME="kafka_2.12-2.3.0"
ZOOKEEPER_HOME="/usr/app/apache-zookeeper-3.5.5"
ZOOKEEPER_NAME="ZOOKEEPER-3.5.5"

echo "INFO : Begin to stop kafka cluster ..."

for server in $servers
do
  echo "INFO : Shut down ${ZOOKEEPER_NAME} on ${server} ..."
  ssh root@$server "ps -ef | grep 'zookeeper' | grep -v grep | awk '{print \$2}'| xargs kill;exit;"
  if [[ $? -ne 0 ]]; then
      echo "INFO : Shut down ${ZOOKEEPER_NAME} on ${server} is down"
  fi
done

echo "INFO : zookeeper cluster shut down completed!"

