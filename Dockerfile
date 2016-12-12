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
WORKDIR /TheUbuntuBox-Config
COPY . /TheUbuntuBox-Config
ADD start-apache2.sh /start-apache2.sh
ADD start-mysqld.sh /start-mysqld.sh
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf

RUN ln -s /etc/supervisor/conf.d/supervisord-apache2.conf supervisord-apache2.conf
RUN ln -s /etc/supervisor/conf.d/supervisord-mysqld.conf supervisord-mysqld.conf 


##
##
WORKDIR /TheUbuntuBox-WebDocument
RUN ln -s /TheUbuntuBox-WebDocument /var/www


##
##
EXPOSE 80
VOLUME /TheUbuntuBox-WebDocument


##
## Environment
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M


##
##
ENTRYPOINT ["/bin/bash", "/TheUbuntuBox-Config/docker-entrypoint.sh"]
CMD ["supervisord -n"]
