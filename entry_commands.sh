#!/bin/bash

PRIVHOST=camacq1
cat /opt/getcams/hosts-cb >> /etc/hosts 
mkdir scratch 
if ! ping -c 3 -W 1 $PRIVHOST; then
	echo Fatal: hpwren.priv not reachable ... exiting ...
	exit 1
fi
exit 0
