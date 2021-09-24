FROM alpine:latest
MAINTAINER scc <workabee@126.com>
ADD jre8.tar.gz /usr/java/jdk/
ENV JAVA_HOME=/usr/java/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin
WORKDIR /opt
COPY locale.md /opt/locale.md
##修改时区
RUN apk add tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.9/main/" > /etc/apk/repositories && \
wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-2.33-r0.apk && \
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-bin-2.33-r0.apk && \
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-i18n-2.33-r0.apk && \
apk add glibc-bin-2.33-r0.apk glibc-i18n-2.33-r0.apk glibc-2.33-r0.apk && \
apk update && apk upgrade && \
rm -rf *.apk && \
rm -rf /var/cache/apk/* \
cat locale.md | xargs -i /usr/glibc-compat/bin/localedef -i {} -f UTF-8 {}.UTF-8 && \
rm -rf locale.md

ENV LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN.UTF-8


