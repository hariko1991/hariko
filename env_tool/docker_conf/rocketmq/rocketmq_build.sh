#!/bin/sh
container_name=rocketmq-$1

if [ "$1" = "a" ];then
  docker stop ${container_name}
  docker rm ${container_name}
  docker run -dit --network=hariko_net --privileged=true --ip 172.18.0.31 --hostname=rocketmq-a --name=rocketmq-a -v /home/hariko/temp/docker/rocketmq/a/logs:/usr/app/temp/logs/ hariko/rocketmq-4.7.0:1.0 /bin/bash -c "sh ./start.sh a"
elif [ "$1" = "b" ];then
  docker stop ${container_name}
  docker rm ${container_name}
  docker run -dit --network=hariko_net --privileged=true --ip 172.18.0.32 --hostname=rocketmq-b --name=rocketmq-b -v /home/hariko/temp/docker/rocketmq/b/logs:/usr/app/temp/logs/ hariko/rocketmq-4.7.0:1.0 /bin/bash -c "sh ./start.sh b"
else
  docker stop rocketmq-a
  docker rm rocketmq-a
  docker stop rocketmq-b
  docker rm rocketmq-b
  docker rmi hariko/rocketmq-4.7.0:1.0
  docker build -t hariko/rocketmq-4.7.0:1.0 ./
fi
