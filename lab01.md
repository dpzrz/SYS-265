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

Once installed we have to edit our config for our network. We do this by moving into the `/etc/snmp/` directory. In that direcotry we have to vim the file `snmpd.conf`. We delete all of its contents and replace it with


<img width="476" alt="image" src="https://github.com/dpzrz/SYS-265/assets/112894794/90015d7e-c5a4-4f9c-8c42-e77a83f6e43b">

After we follow all the steps to activaate a service such as:

* Enable and start the snmpd service
* Check status using `systemctl` command
* allow port 161/udp through the firewall permanaently using `firewall-cmd`


To test our service we are going to query to `web01` from `nmon01`:


<img width="625" alt="image" src="https://github.com/dpzrz/SYS-265/assets/112894794/39d753f7-3e97-4367-96c6-4b44489376e5">

### Configuring our SNMP on AD01

Using out `mgmt01` box we can install features to `ad01`. We need to add this service through roles and features. We chose our `ad01` box and add the SNMP service features, this install is pretty quick. To install SNMP Tools we need to do the same process except we are selecting our `mgmt01` box instead.


Because Remote Management is disabled we need to go into powershell and re-enable it. Use ssh in powershell to access `ad01` from `mgmt01`. Change the firewall rules using this command:

`Set-NetFirewallRule -DisplayGroup "Remote Event Log Management" -Enabled True`

### Configuring SNMP Security Properties on AD01

Using our Computer Management tab in our Tools drop down menu gives us access to oour running services. Clicking our SNMP service allows us to define community names which we set to `SYS265` from this same menu we can add our `nmon01` machine. Then we restart our SNMP Service.

## Notes

Some commands used for testing our SNMP service:

* `tcpdump -1 ens192 -c 10 -X -s 0 port 161` this command allows us to see packets on port 161
* `snmpwalk -Os -c SYS265 -v2c ad01-diego system`
* 

## Terms 
SNMP: Simple Network Management Protocol

Computer Management (Tool): Used to see services runnign on AD01
snmpwalk: retrieve a subtree of management values using SNMP GETNEXT requests 


