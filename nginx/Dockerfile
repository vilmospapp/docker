FROM nginx:latest
ARG liferay_host
ARG tomcat_ip
ARG tomcat_port=8080

RUN apt-get -y update
RUN apt-get install -y mc
RUN apt -y install golang-cfssl

COPY /default.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /etc/nginx/certs && \
    cd /etc/nginx/certs && \
    cfssl print-defaults csr > my-csr.json && \
    sed "s/example.net/${liferay_host}/g" my-csr.json > client-csr.json && \
    apt-get install -y ca-certificates && \
    cfssl gencert --remote https://ssl-generator.herokuapp.com client-csr.json | cfssljson -bare client - && \
    rm my-csr.json && \
    rm client-csr.json
    
#COPY /certs /etc/nginx/certs


RUN sed "s/tomcat_ip/${tomcat_ip}/g" /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default_new.conf && \
    sed "s/tomcat_port/${tomcat_port}/g" /etc/nginx/conf.d/default_new.conf > /etc/nginx/conf.d/default.conf && \
    rm /etc/nginx/conf.d/default_new.conf