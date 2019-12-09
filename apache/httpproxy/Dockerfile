FROM httpd:latest

ARG liferay_host
ARG tomcat_ip
ARG tomcat_http_port=8080

RUN apt-get -y update
RUN apt-get install -y mc
RUN apt -y install golang-cfssl
RUN mkdir -p /usr/local/apache2/conf/ssl

RUN cd /usr/local/apache2/conf/ssl && \
    cfssl print-defaults csr > my-csr.json && \
    sed "s/example.net/${liferay_host}/g" my-csr.json > custom-csr.json && \
    apt-get install -y ca-certificates && \
    cfssl gencert --remote https://ssl-generator.herokuapp.com custom-csr.json | cfssljson -bare client - && \
    rm my-csr.json && \
    rm custom-csr.json

COPY /conf/hosts /usr/local/apache2/conf/hosts
COPY /conf/variables.conf /usr/local/apache2/conf/variables.conf
RUN sed "s/dp_host/${liferay_host}/g" /usr/local/apache2/conf/variables.conf > /usr/local/apache2/conf/variables1.conf && \
    sed "s/dp_ip/${tomcat_ip}/g" /usr/local/apache2/conf/variables1.conf > /usr/local/apache2/conf/variables2.conf && \
    sed "s/dp_port/${tomcat_http_port}/g" /usr/local/apache2/conf/variables2.conf > /usr/local/apache2/conf/variables.conf && \
    rm /usr/local/apache2/conf/variables2.conf && \
    rm /usr/local/apache2/conf/variables1.conf

COPY /conf/httpd.conf /usr/local/apache2/conf/httpd.conf