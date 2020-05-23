#!/bin/sh
export JAVA_OPT=" -Duser.home=/usr/app/temp"
export ROCKETMQ_HOME=/usr/app/rocketmq-4.7.0/
export PATH=$ROCKETMQ_HOME/bin:$PATH
cd ${ROCKETMQ_HOME}/bin
sh mqnamesrv &

if [ "$1" = "a" ];then
  sh mqbroker -c ${ROCKETMQ_HOME}/conf/hariko/broker-a.properties &
  sh mqbroker -c ${ROCKETMQ_HOME}/conf/hariko/broker-b-s.properties &
else
  sh mqbroker -c ${ROCKETMQ_HOME}/conf/hariko/broker-b.properties &
  sh mqbroker -c ${ROCKETMQ_HOME}/conf/hariko/broker-a-s.properties &
fi
tail -f > /dev/null
