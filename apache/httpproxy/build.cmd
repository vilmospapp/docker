@echo off
if "%~2"=="" goto USAGE

if "%~3"=="" goto ALLPARAMS else goto TWOPARAMS

:ALLPARAMS
    docker build  --build-arg liferay_host=$1 --build-arg tomcat_ip=$2 -t ajp-proxy .
    goto:eof

:TWOPARAMS
    docker build  --build-arg liferay_host=$1 --build-arg tomcat_ip=$2 --build-arg tomcat_ajp_port=$3 -t ajp-proxy .
    goto:eof

:USAGE
echo "usage: build {your laptop's hostname} {Tomcat's IP address} {Tomcat's AJP port (default is 8009) this is not mandatory}"
    

