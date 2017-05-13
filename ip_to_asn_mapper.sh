#!/bin/bash

# IP to ASN Mapping
# 02/06/2016
# whois query for IP to ASN mapping for all regional registries.
# Author: AGaldamez

# Declared Variables:
SERVER=v4.whois.cymru.com
PEER_SERVER=v4-peer.whois.cymru.com
PREFIX=-p
REGISTRY=-r

echo -e "\nEnter IPv4 address or Domain:"
read ip
	# Operation for whois details:
	if ! [[ "$ip" =~ ^[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$ ]]
	then	
		# Get IPv4 address from domain:
		ip=$(nslookup $ip | awk '/Address/' | tail -n -1 | awk '{print $2}')
		echo 

		# Get whois details for IPv4 address:
		whois -h $SERVER " -r -p $ip" 

		echo 
		# Get PEER information:
		whois -h $PEER_SERVER $ip

	else	# Get whois details for ipv4 address:
		echo
		whois -h $SERVER " -r -p $ip" 
		
		echo
		# Get PEER information:
		whois -h "$PEER_SERVER" "$ip"
	fi

