FROM alpine:3.8
LABEL maintainer="kaarol@it-flow.pl"

ENV JMETER_VERSION "4.0"

RUN apk update && \
    apk upgrade && \
    apk add --update openjdk8-jre wget tar bash && \
    wget http://mirror.nbtelecom.com.br/apache//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz && \
    tar -zxf apache-jmeter-${JMETER_VERSION}.tgz -C /opt/jmeter && \
    rm -rf apache-jmeter-${JMETER_VERSION}.tgz && \
    rm -rf /var/cache/apk/*

ENV JMETER_HOME /opt/jmeter
