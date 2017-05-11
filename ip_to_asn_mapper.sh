#!/bin/bash

# IP to ASN Mapping
# 02/06/2016
# whois query for IP to ASN mapping for all regional registries.

# Declared Variables:
server=v4.whois.cymru.com
peer_server=v4-peer.whois.cymru.com
prefix=-p
registry=-r

echo -e "\nEnter IPv4 address or Domain:"
read ip
	# Operation for whois details:
	if ! [[ "$ip" =~ ^[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$ ]]
	then	
		# Get IPv4 address from domain:
		ip=$(nslookup $ip | awk '/Address/' | tail -n -1 | awk '{print $2}')
		echo 

		# Get whois details for IPv4 address:
		whois -h $server " -r -p $ip" 

		echo 
		# Get peer information:
		whois -h $peer_server $ip

	else	# Get whois details for ipv4 address:
		echo
		whois -h $server " -r -p $ip" 
		
		echo
		# Get peer information:
		whois -h "$peer_server" "$ip"
	fi

