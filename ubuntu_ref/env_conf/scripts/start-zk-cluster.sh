#!/bin/bash
servers="192.168.0.127 192.168.0.128 192.168.0.129"
KAFKA_HOME="/usr/app/kafka_2.12-2.3.0"
KAFKA_NAME="kafka_2.12-2.3.0"
ZOOKEEPER_HOME="/usr/app/apache-zookeeper-3.5.5"
ZOOKEEPER_NAME="ZOOKEEPER-3.5.5"

echo "INFO : Begin to start zookeeper cluster ..."

for server in $servers
do
  echo "INFO : Starting ${ZOOKEEPER_NAME} on ${server} ..."
  ssh root@$server "source /etc/profile; sh ${ZOOKEEPER_HOME}/bin/zkServer.sh start;exit;"
  if [[ $? -eq 0 ]]; then
      echo "INFO:zookeeper [${server}] Start successfully"
  fi
done
echo "INFO:zookeeper cluster starts successfully !"

