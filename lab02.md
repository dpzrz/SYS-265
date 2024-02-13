# Docker Lab

## Unbuntu Box Setup

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

After this we need to configure our record on our `ad01` machine. We can test this process by uusing hostnames when pinging and checking our dnslookup on each machine. 


### Domain and LAN

We can now start this process only becasue we've configured our dns records and .yml network config. If realm commands arent wokring make sure `realmd` is installed.

Use the command `realm discover name.local`

You should see and output like this:
```
srv.world
  type: kerberos
  realm-name: SRV.WORLD
  domain-name: srv.world
  configured: no
  server-software: active-directory
  client-software: sssd
  required-package: sssd-tools
  required-package: sssd
  required-package: libnss-sss
  required-package: libpam-sss
  required-package: adcli
  required-package: samba-common-bin
```
 After we get this output we can see there are new packages we need to install in order to join the domain. These can all be installed together via the `apt install sssd sssd-tools libnss-sss libpam-sss adcli samba-common-bin oddjob oddjob-mkhomedir packagekit`

 Now we can join our domain, double check you have all the necessary packages installed. Join the domain using the `realm join name.local`. You'll be prompted with a login, use your -adm account. You can now login via adm@diego.local.


## Docker Setup

Its always good practice to update already installed packages, this can be done on Unbuntu by using the `sudo apt update`. 

Were then gonna install a pre-req package that allows us to `apt` packages over HTTPS.

`sudo apt install apt-transport-https ca-certificates curl software-properties-common`

We then need to obtain the GPG key so we can use the offical Docker repo.

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`

Once we have the GPG key added we need to add the Docker repository to our `apt` sources.

`sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"`

Finally Docker can be installed, `sudo apt install docker-ce`

We can monitor the Docker service the same way we would Apache for example. We can use our trusty `systemctl` commands. The docker service should be active.

### Docker Compose Install

We need to install `docker-compose` and this is done via a curl command which will save the executable file at `/usr/local/bin/docker-compose`. This allows th software to be globally accessible as `docker-compose`.

`sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`

After set proper permissions for th file path.

`sudo chmod +x /usr/local/bin/docker-compose`

Verify version info using `docker-compose --version`

### Docker Sudo User

By default the `docker` command can only be run by root user. We dont want to have to type sudo for all these docker commands, so well need to join the docker group of users.

`sudo usermod -aG docker ${username}`

`su - ${username}`

## Docker + Wordpress





## Commands & Notes

