# Lab 03: Git and Linux SSH Script


## Part 1

### Using Git on Docker


Github is what we've been using fro all out tech journals and documentation for CNCS classes. Were utilizing git fro this lab to allow our user to `push` `pull` `clone` and `commit`.


Were first tasked with loading a whole git repositorty made specifically for this lab. For me this repisisotory is named tech-journal-private. Using the git `clone` command we can copy over the entirety of the repo onto our docker machine. 

We create a folder structure for the later portions for this lab. We run through the commands `git add` `git status`.

We have to configure our email and username with git and this is done by the below commands.

* git config user.name _insert username here_
* git config user.email _insert email here_

The `git commit` command trails the repo configs. It commits the changes to the repo.

### Using Git on Windows

Installing Git on widows can be done through a browser and can be found [here](https://git-scm.com/download/win). We use the same commands to clone our repo onto our desktop on MGMNT01. Our windows machine is catching our credentials and email. Using the `-m` tage allows us to commit with a message which cna be modified to descibe each and every change.

For out of sync repos we can utilize the `git pull` command and pull down all changes. 

## Part 2

### Hardening SSH

First, we must install git in web01-diego. Our web boxes use the `yum` package manager compared to the `apt` used in Unbuntu. We clone our current reppository that should be structrued for this second part into web01. On web01-diego we create a .sh file titled `secure-ssh`. This file will be the script fro our passwordless sign-on. After we push to our repo to update it.

On web01 we must create an RSA keypair specifically one with no passphrase. WE then have to copy that PUBLIC key the local repo files. The comand we use for this is `cp`. After push and commit. 

Now back on our docker01 box, we have to perform a git pull to sync the local repo. 

### SSH Script

Were now taske dto write a script that will take a username as a parameter and create a paswordless sign-on user. This process also utilizes the public key we now have copied into our repos. Were given and example of how to manually do this. And tasked to complete it once manually.

```
sudo useradd -m -d /home/sys265 -s /bin/bash sys265
sudo mkdir /home/sys265/.ssh
sudo cp SYS265/linux/public-keys/id_rsa.pub /home/sys265/.ssh/authorized_keys sudo chmod 700 /home/sys265/.ssh
sudo chmod 600 /home/sys265/.ssh/authorized_keys 
sudo chown -R sys265:sys265 /home/sys265/.ssh
```

Our scrpit will consist of these commands with a Username variable that has to be user inputted.

```
#secure-ssh.sh
#author dperez
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled from the remote reop
#removes roots ability to ssh in

# Check if script is run with sudo
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run with sudo."
    exit 1
fi

# Prompt for the username
read -p "Enter the username for the new user: " USERNAME

# Check if username is provided
if [ -z "$USERNAME" ]; then
    echo "Username is required."
    exit 1
fi

# Create user with home directory and specified shell
sudo useradd -m -d "/home/$USERNAME" -s /bin/bash "$USERNAME"

# Check if user is added successfully
if [ $? -ne 0 ]; then
    echo "Failed to add user $USERNAME."
    exit 1
fi

# Create .ssh directory and copy public key
sudo mkdir "/home/$USERNAME/.ssh"
sudo cp /home/diego/tech-journal-private/public-keys/id_rsa.pub "/home/$USERNAME/.ssh/authorized_keys"

# Set correct permissions
sudo chmod 700 "/home/$USERNAME/.ssh"
sudo chmod 600 "/home/$USERNAME/.ssh/authorized_keys"
sudo chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.ssh"

echo "Passwordless SSH access setup for user $USERNAME."

```

This script can be found [here](https://github.com/dpzrz/SYS-265/blob/main/secure-ssh.sh)

## Commands & Notes

Git Commands
 * `git pull` Fetch from and integrate with another repository or a local branch
 * `git push` Update remote refs along with associated objects
 * `git clone` Clone a repository into a new directory
 * `git commit -m` Record changes to the repository, the -m flag allows for a message
 * `git add` Add file contents to the index
 * `git status` Show the working tree status

Other Commands
 * `apt install` The apt install command installs a specified package from the repository, in our case used in Unbuntu
 * `./` Put before the title of the .sh file and the format for running bash scripts.
 *  `ssh-keygen` Ssh-keygen is a tool for creating new authentication key pairs for SSH
   
