#!/bin/bash

awk '{ if($0 ~ /remote /) { print $3; }}' /etc/openvpn/openvpn.ovpn

