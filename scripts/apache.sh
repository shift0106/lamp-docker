#!/bin/sh

. /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND
