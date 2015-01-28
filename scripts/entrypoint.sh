#!/bin/sh

if [ -d "/opt/sbin/init.d" ]
then
	for script in `find /opt/sbin/init.d -name "*.sh"`
	do
		. $script
	done
fi

supervisord -n -c /etc/supervisord.conf
