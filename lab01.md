# Lab 01: Network Management

### Configuring web01-diego

Web01 is a Linux based CentOS machine so we can utilize `nmtui` to configure all our network settings. We assigned web01 with a static IP address of `10.0.5.200/24`. This machine will not be connected to our local domain we created. With everynew machine we have to configure our DNS records so we can resolve the new machines. 

### Configuring fw01-diego

We need to enable SNMP services of our `fw01 box`. To achieve this we utilize the pfsense web portal which allows us to change these settings within a gui. We have access to this web gui on our `wks-01 box`. In the web gui you have to navigate to the hamburger menu and click on the Services tab and find SNMP. Our changes include setting the Community String, in this example its set to SYS265. We also change the bind interfaces to LAN.

### Configuring nmon01

Nmon01 is another CentOS box so we use nmtui to do the same process we did with out web01 box. Our assigned IP address is `10.0.5.11/24`. This box we are connecting to our local domain. In our nmtui we can just add the domain yourname.local. This box will be accesed by PuTTY so we also have to disable root SSH.

### Installing SNMP & SMNPD

We need to install SNMP client on our `nmon01 box` to do this we use this command:

* `sudo yum install net-smnp-utils`

We can output the SNMP values on fw01 by using this command:

* `snmpwalk -Os -c SYS265 -v2c fw01-diego system`

Next we must install the SNMPD server on `web01`. To do this we use a similar command to the previous install:

* `sudo yum install net-snmp-utils net-snmp`

### Configuring
## Notes

## Terms


