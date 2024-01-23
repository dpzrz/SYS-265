# Lab 00

### Physical Setup
  This lab is a setup lab so we are able to use these machines as a domain. We first start with cabling each box to LAN. Our fs01 VM will be cabled to WAN and LAN as it will be our fireway and provide our domain with internet access.

### FW01
  Assign the WAN to em0 and the LAN to em1. The WAN will be set to `10.0.7.115`, this was given to us by our professor and will allow our networks to communicate with oue outside server. The LAN will be set to `10.0.5.2` this will server as our default gateway IP. We skip over the IPv6 and DHCP options. 

  To test our new configuration we can ping google through Pfsense. We ping 8.8.8.8 and if we recive pings back then we can confirm our gateway is working. 

### WKS01
  On our Windows VM we need to prep our system and grant it internet access. We start by giving this workstation a static IP address of `10.0.5.100`. The netmask for this configuration is /24. We then add our gateway from our previous VM, we assign our DNS to `10.0.5.2`. Finally we change the hostname to wks01-yourename, this allows for easy discoverability when doing records.

Using our internet connection we cn configure our fw01 thriugh its web gui. We access this by using our LAN gateway as a url. The FW wizard makes the setup simple. The password used to create this account should be saved. 

### AD01
  Our Server Core is CLI based and has no gui which is diffrent than our AD01 server from last semester. To assigne network configugarations we use the command `sconfig`. This command allows us to easily set the static IP of `10.0.5.5/24`. We set our gateway to `10.0.5.2` along with our perferred DNS. 





