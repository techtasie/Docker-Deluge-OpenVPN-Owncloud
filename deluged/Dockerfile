FROM lsiobase/ubuntu:bionic

# Enviorment Variables
ARG DEBIAN_FRONTEND="noninteractive"


# Install Packages

RUN \
 echo "**** add repositories ****" && \
 apt-get update && \
 apt-get install -y \
	gnupg && \
 apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C5E6A5ED249AD24C && \
 echo "deb http://ppa.launchpad.net/deluge-team/stable/ubuntu bionic main" >> \
	/etc/apt/sources.list.d/deluge.list && \
 echo "deb-src http://ppa.launchpad.net/deluge-team/stable/ubuntu bionic main" >> \
	/etc/apt/sources.list.d/deluge.list && \
 echo "**** install packages ****" && \
 apt update && \
 apt install -y \
	deluged \
	deluge-console \
	deluge-web \
	python3-future \
	python3-requests \
	p7zip-full \
	unrar \
	unzip \
	openvpn \
	dnsutils \
	net-tools \
	iptables \
	ufw \
	net-tools \
	curl \
	traceroute \
	kmod \
	easy-rsa && \
 echo "**** cleanup ****" && \
 rm -rf \
	/var/lib/apt/lists/* \
	/tmp/* \
	/var/tmp/*

# Disable IPv6 capability for ufw because the IPv6 module makes some problems sometimes
RUN sed -i 's/IPV6=yes/IPV6=no/g' /etc/default/ufw

# RUN apt update && apt install -y linux-image-$(uname -r)
WORKDIR /home

COPY main.sh main.sh
COPY DomainExtractor.sh DomainExtractor.sh
COPY Firewall.sh Firewall.sh
COPY IpExtractor.sh IpExtractor.sh
COPY OpenVPNconfig.sh OpenVPNconfig.sh
COPY PortExtractor.sh PortExtractor.sh

VOLUME /config /root/Downloads /completed

EXPOSE 8112 58846 58946 58946/udp

#CMD ./main.sh
CMD tail -f main.sh
