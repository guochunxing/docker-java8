FROM alpine:latest
MAINTAINER scc <workabee@126.com>
ADD jre8.tar.gz /usr/java/jdk/
ENV JAVA_HOME=/usr/java/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.9/main/" > /etc/apk/repositories && \
wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk && \
apk add glibc-2.30-r0.apk && \
apk update && apk upgrade && \
rm -rf *.apk && \
rm -rf /var/cache/apk/*

WORKDIR /opt
