#!/bin/bash
#
# Released under the GNU Lesser GPL v. 2.1
# Last edit by elofturtle <jonatan@linux.com> 2013-08-13
#####################################################################

if [[ $# != 0 && $# != 1 && $# != 2 ]]; then
	echo "Invalid number of arguments. Exiting,"
	exit
fi

sudo ifconfig wlan0 up

#####################################################################

if [[ $1 == "default" ]]; then
	if [[ $# == 2 ]] ; then
		ESSID="$2";
	else
		ESSID="Semaphora";
	fi

	sudo iwconfig wlan0 essid "$ESSID"

elif [[ $1 == "disconnect" ]]; then		# Probably should do something fancier at some point.cd
	sudo ifconfig wlan0 down
	exit
elif [[ -f /etc/wpa_supplicant/$1 ]]; then
	sudo wpa_supplicant -B -iwlan0 -c/etc/wpa_supplicant/"$1"
else
	echo "Unknown base station. Printing help."
	echo "Valid choices are: \"default\", \"disconnect\", or a valid wpa_config file in"
	echo "directory /etc/wpa_supplicant/"
	exit
fi

######################################################################

sudo dhclient wlan0

# Don't piss off google, unless really unreliable connection.
#echo "Testing Connection (pinging Google):"
#echo "If this works, wifi is fully operational!"
#ping -c 1 www.google.com
#echo
