#!/bin/bash
DnsCheck()
{
	#Based on the windows DNS check as long windows detects that the dns is working this works too.
	if [[ $(dig +short dns.msftncsi.com) = "131.107.255.255" ]]; then
		echo "DNS Up";
		return 0;
	else
		echo "DNS Down"
		return 1;
	fi
}
InternetCheck()
{
	#Google never goes down so this will work for a long time.
	if curl -s google.com > /dev/null ; then
		echo "Internet available";
		return 0;
	else
		echo "Internet not available";
		return 1;
	fi
}	

OnlineCheck()
{
	if ! DnsCheck ; then
		sleep 30; #Wait 30sec and try again
		if ! DnsCheck ; then
			echo "turn off because DNS seems to be not available.";
			exit;
		fi
	fi
	

	if ! InternetCheck ; then
		sleep 30; #Wait 30sec and try
		if ! InternetCheck ; then
			echo "Internet Connection Lost";
			exit;
		fi
	fi
}
IP_BEFORE=""
FirewallCheck()
{
	if DnsCheck ; then
		echo "ERROR: Firewall does not block DNS";
		exit;
	fi
	
	if InternetCheck ; then 
		echo "ERROR: Firwall does not block internet";
		exit;
	fi
}

IpCheck()
{
	NEW_IP=$( curl -s ifconfig.me ) 
	if [ "$IP_BEFORE" = "$NEW_IP" ]; then
		echo "ERROR: IP is the same!! INITIATE SHUTDOWN";
		exit;
	else
		echo "VPN has masked the IP";
	fi
}	
Privelage()
{
	chown -R abc:abc /config
	chown -R abc:abc /root/Downloads
	chown -R abc:abc /complete
}

Init()
{
	Privelage;
	OnlineCheck;
	
	IP_BEFORE=$( curl -s ifconfig.me );
	echo "Normal IP is: "$IP_BEFORE;

	./OpenVPNconfig.sh;
	./Firewall.sh;

	FirewallCheck;
	
	service openvpn start;
	sleep 30;
	
	OnlineCheck;
	IpCheck;
	
	deluged -c /config;
	deluge-web -c /config;
}

Loop()
{
	IpCheck;
	OnlineCheck;
	sleep 5m;
	Loop;
}	


Init;
Loop;
