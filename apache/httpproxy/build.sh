#!/bin/bash

if [ $# -lt 2 ]; then
    echo "usage: build {your laptop's hostname} {Tomcat's IP address} {Tomcat's HTTP port (default is 8009) this is not mandatory}"
    exit
fi
if [ $# -lt 3 ]; then
    docker build  --build-arg liferay_host=$1 --build-arg tomcat_ip=$2 -t http-proxy .
    exit
fi

docker build  --build-arg liferay_host=$1 --build-arg tomcat_ip=$2 --build-arg tomcat_http_port=$3 -t http-proxy .

