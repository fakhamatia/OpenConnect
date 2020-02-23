#!/bin/bash

username=""
password=""
servercert=""
server=""
server2=""

checkTor=$(dpkg-query -W -f='${Status} ${Version}\n' tor 2>&1 | grep -oh 'installed')
checkAnydesk=$(dpkg-query -W -f='${Status} ${Version}\n' anydesk 2>&1 | grep -oh 'installed')

if pgrep -x "openconnect" >/dev/null; then
	sudo killall "openconnect"
	sleep 2
	gnome-terminal --execute bash -c "echo $password | sudo openconnect $server2 --user=$username --passwd-on-stdin --servercert $servercert"
	if [ "$checkTor" == 'installed' ]; then
		sleep 2
		sudo systemctl restart tor.service
	fi
	if [ "$checkAnydesk" == 'installed' ]; then
		sleep 2
		sudo systemctl restart anydesk.service
	fi
else
	gnome-terminal --execute bash -c "echo $password | sudo openconnect $server --user=$username --passwd-on-stdin --servercert $servercert"
	if [ "$checkTor" == 'installed' ]; then
		sleep 2
		sudo systemctl restart tor.service
	fi
	if [ "$checkAnydesk" == 'installed' ]; then
		sleep 2
		sudo systemctl restart anydesk.service
	fi
fi
