FROM openjdk:8u102-jdk
COPY rocketmq-4.7.0.tar.gz rocketmq-4.7.0.tar.gz
ADD start.sh /start.sh
ENV ROCKETMQ_VERSION 4.7.0
ENV ROCKETMQ_HOME /usr/app/rocketmq-${ROCKETMQ_VERSION}
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone \
    && mkdir -p /usr/app/temp \
    && mv /rocketmq-4.7.0.tar.gz /usr/app/ \
    && cd /usr/app \
    && tar -zxvf rocketmq-4.7.0.tar.gz \
    && rm rocketmq-4.7.0.tar.gz \
    && cd rocketmq-4.7.0/bin \
    && chmod +x mqnamesrv \
    && chmod +x mqbroker \
    && chmod +x /start.sh
    #&& cp -rf /start.sh /etc/profile.d/ \
    #&& cp -rf /start.sh /etc/init.d/ \
    #&& cd /etc/init.d/ \
    #&& chkconfig -add /etc/profile.d/start.sh \
    #&& chkconfig /etc/profile.d/start.sh on
#CMD cd ${ROCKETMQ_HOME}/bin && export JAVA_OPT=" -Duser.home=/usr/app/temp" \
#    && sh mqnamesrv \
#    && sh mqbroker -c ../conf/hariko/broker-a.properties \
#    && sh mqbroker -c ../conf/hariko/broker-b-s.properties
#CMD ["sh", "/start.sh"]
#ENTRYPOINT ["/bin/sh", "/usr/app/rocketmq-4.7.0/bin/start.sh"]


EXPOSE 9876
