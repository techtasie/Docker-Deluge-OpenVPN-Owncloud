#!/bin/bash

#By default is any trafic forbidden
ufw default deny incoming > /dev/null
ufw default deny outgoing > /dev/null

#But internal network traffic is usualy no porblem
ufw allow from 10.0.0.0/8 > /dev/null
ufw allow to 10.0.0.0/8 > /dev/null

ufw allow from 172.16.0.0/12 > /dev/null
ufw allow to 172.16.0.0/12 > /dev/null

ufw allow from 192.168.0.0/16 > /dev/null
ufw allow to 192.168.0.0/16 > /dev/null

# Allow local IPv6 connections
ufw allow from fe80::/64 > /dev/null
ufw allow to fe80::/64 > /dev/null


#Allow any VPN trafic
ufw allow in  on tun0 from any > /dev/null
ufw allow out on tun0 from any to any  > /dev/null

#Allow connection to the VPN itself
ufw allow in on eth0 from $(./IpExtractor.sh) > /dev/null
ufw allow out on eth0 from any to  $(./IpExtractor.sh) > /dev/null


#Enable this rules
ufw enable
