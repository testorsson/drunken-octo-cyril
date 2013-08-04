#!/bin/bash

# Because I'm too lazy to make it an automount.
# No safeguards, of course. That would take effort considering I only have one usb port on the target machine...
# Anyhow, also good template since I always forget this.
# Released under the GNU Lesser Public License version 2.1 or later.
# elofturtle <jonatan@linux.com> 2013-08-01
#################################################################################################################

if [[ $# > 1 ]] ; then
	exit;
fi

if [[ $# == 1 ]] ; then
	foo=$1;
else
	foo="sda1";
fi

if [[ $foo == "unmount" ]] ; then
	sudo umount /media/usb
else
	sudo mount -t vfat /dev/$foo /media/usb -o uid=1000,gid=1000,utf8,dmask=027,fmask=137
fi

