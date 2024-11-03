#!/bin/bash

service dbus start
service avahi-daemon start
#/usr/sbin/cupsd -C /etc/cups/cupsd.conf -s /etc/cups/cups-files.conf 
service cups start
while [ 1==1 ]
do
  sleep 1
done
