#!/bin/bash
STARTHAPROXY="/usr/local/haproxy/sbin/haproxy -f /usr/local/haproxy/haproxy.cfg"
STOPKEEPALIVED="/etc/init.d/keepalived stop"
LOGFILE="/usr/local/keepalived/var/log/keepalived-haproxy-state.log"

echo "[check_haproxy status]" >> $LOGFILE

A=`ps-C haproxy --no-header |wc-l`
echo "[check_haproxy status]" >> $LOGFILE
date >> $LOGFILE
if [ $A -eq 0 ];then
	echo $STARTHAPROXY >> $LOGFILE
	$STARTHAPROXY >> $LOGFILE  2>&1
	sleep5
fi

if [ `ps -C haproxy --no-header |wc-l` -eq 0 ];then
	exit 0
else
	exit 1
fi

counter=$(ps -C nginx --no-heading|wc -l)
if [ "${counter}" = "0" ]; then
    /usr/local/nginx/sbin/nginx
    sleep 2
    counter=$(ps -C nginx --no-heading|wc -l)
    if [ "${counter}" = "0" ]; then
        /etc/init.d/keepalived stop
    fi
fi