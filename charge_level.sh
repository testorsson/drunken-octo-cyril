#!/bin/bash

# Display laptop battery charge percentage.
# Works on Ubuntu 12.04 for the Tegre based Toshiba AC100-10D.
# Released under the GNU Lesser GPL v. 2.1 or later.
# elofturtle <jonatan@linux.com> 2013-08-01.
##############################################################

foo=$(< /sys/class/power_supply/battery/charge_full);
bar=$(< /sys/class/power_supply/battery/charge_now);

echo "Battery: $(( 1+ (100*$bar)/$foo ))%";
