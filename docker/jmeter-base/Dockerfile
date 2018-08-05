FROM alpine:3.8
LABEL maintainer="kaarol@it-flow.pl"

ENV JMETER_VERSION "4.0"

RUN apk update && \
    apk upgrade && \
    apk add --update openjdk8-jre wget tar bash && \
    wget http://mirror.nbtelecom.com.br/apache//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz && \
    mkdir -p /opt/jmeter && \
    tar -zxf apache-jmeter-${JMETER_VERSION}.tgz -C /opt/jmeter/  --strip-components=1 && \
    rm -rf apache-jmeter-${JMETER_VERSION}.tgz && \
    rm -rf /var/cache/apk/* && \
    wget -O /usr/bin/tpl https://github.com/schneidexe/tpl/releases/download/v0.4.4/tpl-linux-amd64 && \
    chmod +x /usr/bin/tpl

ENV JMETER_HOME /opt/jmeter
ENV PATH $PATH:$JMETER_HOME/bin
