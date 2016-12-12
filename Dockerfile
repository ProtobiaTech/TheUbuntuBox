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
WORKDIR /TheConfig
COPY . /TheConfig
ADD start-apache2.sh /start-apache2.sh
ADD start-mysqld.sh /start-mysqld.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf


##
##
EXPOSE 80
# VOLUME /WebDocument


##
## Environment
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M


##
##
ENTRYPOINT ["/bin/bash", "/WebDocument/docker-entrypoint.sh"]
CMD ["supervisord -n"]
