FROM ubuntu:trusty
MAINTAINER Rod <rod@protobia.tech>

# Install packages
RUN apt-get update \
    && apt-get install -y \
    supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen php-apc php5-mcrypt \
    curl \
    && echo "ServerName localhost" >> /etc/apache2/apache2.conf


##
##
WORKDIR /WebDocument
COPY . /WebDocument
RUN chown -R :www-data . && chmod g+w .


##
##
EXPOSE 80
VOLUME /WebDocument


##
## Environment
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M


##
##
RUN pwd && ls -la && ls -la /WebDocument
ENTRYPOINT ["/bin/bash", "/WebDocument/docker-entrypoint.sh"]
CMD ["supervisord -n"]
