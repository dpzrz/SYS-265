# Docker Lab

## Setup

This new vm is going to house our Docker service. This new VM is running an Unbuntu server which is debian based. Our last linux VMs have all been based in CentOS7. This change is most prevelant in the commands used, along with the initial setup. 

### Network
The first step is setting up our basic network function. This is done through netplan and configured using a `.yaml` file rather than through `nmtui`. This file is located in `/etc/netplan/`. This `.yml` file has a specific syntax when it comes to spacing. 

This was the config I used on the .yml file. This config allowed for me to connect to our established LAN.

```
network:
  renderer: networkd
  ethernets:
    ens160:
      dhcp4: no
      addresses:
        - 10.0.5.12/24
      routes:
        - to: default
          via: 10.0.5.2
      nameservers:
        search:
          - "diego.local"
        addresses: [10.0.5.5]
  version: 2
  ```


### Domain and LAN

## Docker Set-up


### Commands & Notes
