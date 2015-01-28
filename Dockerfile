FROM ubuntu:12.04
MAINTAINER QiuLin Wang <wangql@fuyinshidai.com>
ENV REFRESHED_AT 2015-01-28

# Pull all the updates
RUN apt-get -yqq update

# Install apt utilities
RUN apt-get -yqq install python-setuptools python-software-properties

# Add ppa:ondrej/php5
RUN add-apt-repository ppa:ondrej/php5

# Update apt sources after added a ppa(Personal Package Archives)
RUN apt-get -yqq update

# Install Apache2
RUN apt-get -yqq install apache2 libapache2-mod-php5

# Install PHP5.5 and php5 modules we needed
RUN apt-get -yqq install php5 php5-apcu php5-gd php5-mysql
RUN apt-get -yqq install php5-redis php5-curl php5-json php5-intl php5-mcrypt php5-imagick imagemagick

# Install mysql server
RUN apt-get -yqq install mysql-server

# Install redis server
RUN apt-get -yqq install redis-server

# Enable apache2 rewrite and php5 module by default
RUN a2enmod rewrite
RUN a2enmod php5

# Disable default apache2 site
RUN a2dissite 000-default.conf

# Enable PHP5 module mcrypt
RUN php5enmod mcrypt

# Install supervisor
RUN easy_install supervisor

# Setup supervisor
ADD conf/supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/run/supervisor
RUN mkdir -p /var/log/supervisor
ADD scripts/apache.sh /opt/supervisor/apache.sh

ADD scripts/entrypoint.sh /opt/sbin/entrypoint.sh
RUN chmod +x /opt/sbin/entrypoint.sh

VOLUME [ "/data/www", "/opt/sbin/init.d", "/etc/apache2", "/etc/php5", "/etc/mysql", "/var/log/apache2", "/var/log/mysql" ]

EXPOSE 80
EXPOSE 443
EXPOSE 3306
EXPOSE 6379

ENTRYPOINT [ "/opt/sbin/entrypoint.sh" ]
