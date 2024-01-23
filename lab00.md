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

The next step is to install our AD, we need to utilize powershell commands this time around to aid our installation. To invoke powershell in our CLI we can just type out powershell then hit enter.

The command we need to install our services is `Install-WindowsFeature AD-Domain-Services -IncludeManagementTools`

 To install the Forrest we need the following command `Install-ADDSForest -DomainName diego.local`

 Follow the install prompts to finish the setup.

### MGMNT01

This is a new type of workstation, its descirbed as a management VM for our AD01 machine. Since our AD01 doesnt have a GUI we can use Server Manager on our MGMNT01 to manage it. We assign MGMNT01 with a static IP of `10.0.5.10`. Our gateway is set to `10.0.5.2`. The DNS will be set diffrently, were using the IP of AD01 `10.0.5.5`. 

We joing to our new domain, then open our Server Manager and install all our AD DS tools and management roles. This download will take some time. After we add ad01 to our list of servers. 

Using our newly installed Active Directory Users and Computers, we can create the following 

- named users first.lastname (normal user) 
- first.lastname-adm (named domain admin)

These users will be used throught our domain network.

Our next step will be to populate our AA and PTR records so we can acknowldege our network on iither computers. To be able to configure these items we need to access our DNS manager and create a new Reverse lookup Zone fro the 10.0.5 network. Create an A record and PTR record fro fw01-diego. Then manually add the PTR records fro ad01 and mgmt01. 

*NOTE The perferred DNS server need to be set to ad01*

For WKS01 we can join the worstation without any problem using the control panel system section. 



