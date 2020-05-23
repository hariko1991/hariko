FROM openjdk:8u102-jdk
COPY rocketmq-console-ng-1.0.1.jar rocketmq-console-ng-1.0.1.jar
ENV JAVA_OPTS="\
-server \
-Xmx512m \
-Xms512m \
-Xmn128m \
-XX:SurvivorRatio=8 \
-XX:MetaspaceSize=128m \
-XX:MaxMetaspaceSize=128m \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=4 \
-XX:+UseParallelOldGC \
-XX:+UseAdaptiveSizePolicy \
-XX:+PrintGCDetails \
-XX:+PrintTenuringDistribution \
-XX:+PrintGCTimeStamps \
-XX:+HeapDumpOnOutOfMemoryError \
-XX:HeapDumpPath=/var/log/jvm/ \
-Xloggc:/var/log/jvm/gc.log \
-XX:+UseGCLogFileRotation \
-XX:NumberOfGCLogFiles=5 \
-XX:GCLogFileSize=10M"
ENTRYPOINT java ${JAVA_OPTS} -Duser.timezone=GMT+8 -Duser.home=/usr/app/temp -Dfile.encoding=UTF-8 -jar /rocketmq-console-ng-1.0.1.jar
