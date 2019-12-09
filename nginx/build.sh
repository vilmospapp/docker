#!/bin/bash

if [ $# -lt 2 ]; then
    echo "usage: build {your laptop's hostname} {your tomcat's ip address} {tomcat's http port, defaults to 8080}"
    exit
fi
if [ $# -eq 3 ]; then
    docker build  --build-arg liferay_host=$1 --build-arg tomcat_ip=$2 --build-arg tomcat_port=$3 -t nginx-proxy .
fi
docker build  --build-arg liferay_host=$1 --build-arg tomcat_ip=$2 -t nginx-proxy .
