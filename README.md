# lamp-docker
LAMP based on ubuntu-12.04, using supervisor to manage apache, mysql server, redis server

# Overview
This image is based on ubuntu:12.04.

Apache, PHP5, MYSQL server, Redis server and Supervisor is installed. PHP5 uses a ppa - ondrej/php5, you can find this ppa on: https://launchpad.net/~ondrej/+archive/ubuntu/php5 .

Avaliable php5 modules are php5-apcu, php5-gd, php5-mysql, php5-redis, php5-curl, php5-json, php5-intl, php5-mcrypt, php5-imagick(imagemagick is also added).

Apache listens on port 80 and 443, MYSQL server listens on 3306, Redis server listens on 6379. Web applications are placed in '/data/www'.

By default, Supervisor listens on 127.0.0.1:9001, using authentication to connect to the supervisor server, default username and password is supervisor/pw2bemodified.

# Usage
You can create a docker container with this image like this(I suppose your web application placed in /srv/docker-example/www):
docker run -d -v /srv/docker-example/www:/data/www -P -–name=“your-lamp-docker-container-name” qiulinwang/lamp

If you want to control every servers configuration, then you should create your docker container like this:
docker run -d -v /srv/docker-example/www:/data/www -v /srv/docker-example/conf/apache2:/etc/apache2 -v /srv/docker-example/conf/php5:/etc/php5 -v /srv/docker-example/conf/mysql:/etc/mysql -P -–name=“your-lamp-docker-container-name” qiulinwang/lamp
note:I suppose you placed your apache/php/mysql configuration files in /srv/docker-example/conf/apache2, /srv/docker-example/conf/php5, and /srv/docker-example/conf/mysql, and your application sources in /srv/docker-example/www.

If you want to inspect server logs, then you can achieve this the following way:
docker run -ti --rm --volumes-from your-lamp-docker-container-name ubuntu:12.04 /bin/bash
Then you can check logs in /var/log.
