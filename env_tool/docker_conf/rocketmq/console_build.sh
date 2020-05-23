docker stop rocketmq-console
docker rm rocketmq-console
docker rmi hariko/rocketmq-console:1.0
docker build -f console.dockerfile -t hariko/rocketmq-console:1.0 ./
docker run -dit --network=hariko_net -p 8181:8080 --ip 172.18.0.33 --hostname=rocketmq-console --name=rocketmq-console -v /home/hariko/temp/docker/rocketmq/console/logs:/usr/app/temp/logs/ hariko/rocketmq-console:1.0
