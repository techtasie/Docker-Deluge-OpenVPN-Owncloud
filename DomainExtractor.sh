#!/bin/bash

awk '{ if($0 ~ /remote /) { print $2; }}' /etc/openvpn/openvpn.ovpn

