#!/bin/bash
# turn on bash's job control
set -m
# Start the primary process and put it in the background
/usr/lib/nut/snmp-ups -a apcups -DD &
# Start the helper process
/usr/lib/nut/upsd -DD
# the my_helper_process might need to know how to wait on the
# primary process to start before it does its work and returns
# now we bring the primary process back into the foreground
# and leave it there
##fg %1
