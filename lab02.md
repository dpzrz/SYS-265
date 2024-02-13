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

Installing a Wordpress serveri e using docker is actually quite simple once you get a hang of the commands and basic workflow.

We've been givne a resource to use by the way of a Github repository : [Quickstart: Compose and Wordpress](https://github.com/docker/awesome-compose/tree/master/wordpress-mysql)

For these copy pasting `PuTTy` is neccesary.

I created a directory for this file as I didnt want it hanging around in my file system. I then used vim to create the compose.yaml file. 

The .yaml file looks like this:

```
services:
  db:
    # We use a mariadb image which supports both amd64 & arm64 architecture
    image: mariadb:10.6.4-focal
    # If you really want to use MySQL, uncomment the following line
    #image: mysql:8.0.27
    command: '--default-authentication-plugin=mysql_native_password'
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=somewordpress
      - MYSQL_DATABASE=wordpress
      - MYSQL_USER=wordpress
      - MYSQL_PASSWORD=wordpress
    expose:
      - 3306
      - 33060
  wordpress:
    image: wordpress:latest
    ports:
      - 80:80
    restart: always
    environment:
      - WORDPRESS_DB_HOST=db
      - WORDPRESS_DB_USER=wordpress
      - WORDPRESS_DB_PASSWORD=wordpress
      - WORDPRESS_DB_NAME=wordpress
volumes:
  db_data:
```

The syntax used for this type of file is very specific.

The database we will use in this config will be `mariadb` which has been used for our wiki install using LAMP stack.

We can navigate to the .yaml file and use the command `docker compose up -d`. This will trigger progress bars and a readout of installation.

We can use our command `docker ps` to see the cointainers that are running and the port mapping. If these ports differ then we have to use `firewall-cmd` to allow access.

Youre output should look like this:

```
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                 NAMES
5fbb4181a069        wordpress:latest    "docker-entrypoint.s…"   35 seconds ago      Up 34 seconds       0.0.0.0:80->80/tcp    wordpress-mysql_wordpress_1
e0884a8d444d        mysql:8.0.19        "docker-entrypoint.s…"   35 seconds ago      Up 34 seconds       3306/tcp, 33060/tcp   wordpress-mysql_db_1
```

After this is complete you can now naviagte to youre local ip address on an internet browser and configure your wordpress.


## Commands & Notes

Docker commands:

* `docker ps`: List containers
* `docker rm`: Remove one or more containers
* `docker version`: Shows version info for the current Docker install
* `docker run`: This can be used to run commands through a container

