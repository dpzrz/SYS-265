# Lab 00

### Physical Setup
This lab is a setup lab so we are able to use these machines as a domain. We first start with cabling each box to LAN. Our fs01 VM will be cabled to WAN and LAN as it will be our fireway and provide our domain with internet access.

### FW01
Assign the WAN to em0 and the LAN to em1. The WAN will be set to `10.0.7.115`, this was given to us by our professor and will allow our networks to communicate with oue outside server. The LAN will be set to `10.0.5.2` this will server as our default gateway IP. We skip over the IPv6 and DHCP options. 

To test our new configuration we can ping google through Pfsense. We ping 8.8.8.8 and if we recive pings back then we can confirm our gateway is working. 

### WkS01





