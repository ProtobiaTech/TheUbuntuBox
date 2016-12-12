FROM ubuntu:14.04
MAINTAINER Rod <rod@protobia.tech>

##
RUN apt-get update \
    && apt-get install -y \
        git \
        curl


##
## 安装 node npm 等
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash \
&& apt-get install -y nodejs \
&& npm install -g bower \
&& npm install -g bower-npm-resolver


##
## 安装 Composer，此物是 PHP 用来管理依赖关系的工具
RUN curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer


##
##
EXPOSE 80
VOLUME /WebDocument

ENTRYPOINT ["/bin/bash", "/app/docker-entrypoint.sh"]
CMD ["/bin/bash"]
