# Automation with Ansible

## Pre-Lab
Were given three new boxes with some conflicting OS specific setups. Our `controller` box is Unbuntu, our `ansible01` is CentOS and our `ansible02` is RockyOS.

**IP Assignments**
- `controller`: 10.0.5.90
- `ansible01`: 10.0.5.91
- `ansible02`: 10.0.5.92

This Pre-Lab differs becasue we ares instructed to crate two multiple users for each box. 

On the `controller` box we need a named sudo user with you're username and a sudo user called deployer. For the other two boxes we can create one user named deployer. **All passwords for deployer should be the same**

## Ansible Install
[Ansible](https://www.redhat.com/en/technologies/management/ansible?extIdCarryOver=true&sc_cid=701f2000001OH6uAAG) is an automation tool in its simplest form. Through this program were going to implimate more automation through the labs.

Were installing Ansible on our `controller` box under our `deployer` user. The command used for Unbuntu install is `apt install`. Our install command is `sudo apt install ansible sshpass python3-paramiko`.

### Sudoers Config
Were gona configure our sudo rules to allow for a passwordless sudo for deployer users. To start this process we need to create a file structure within `sudoers.d`, It'll look like this:

```
etc
└── sudoers.d
    └── sys265
```

The sys265 file has a line that allows sudo eleavtion without a password.

```

 deployer    ALL=(ALL)    NOPASSWD: ALL

```

### RSA key Config
Along with the chnage in sudo rules we also need paswordless ssh'ing from controller to both ansible boxes. We generate then copy that public key to our asnible machines. 

Once we have our passwordless login we can move onto Ansible testing. 




## Ansible Tests
We first need to set up a direcotry path on controller `/home/deployer/ansible/roles`. We then need to place an inventory.txt file containing the hosts we have in that /roles directory

Our inventory.txt file should look something like this:
```
ansible01-diego
ansible02-diego
```

We can test our connection using an asnible command `ansible all -m ping -i inventory.txt`

We can run commands through our machines using ansible with that same command structure.

We need to sort our mahcines into groups for our install of `webmin`. To accomplish this we edit our inventory.txt file and add a group. The syntax for this can be seen bellow:

```
ansible01-diego
[webmin]
ansible02-diego
```

Were going to deploy webmin on our asnible02 machine but this requires two steps.
* Install webmin through `ansible-galaxy` using the repo from semuadmin, `asnible-galaxy role install semuadmin.webmin -p roles/`
* Second is creating a playbook that can install this role on our specified boxes.

There is a syntax config that must be changes as were isntalling on a RockyOS box. The change lies in `/ansible/roles/semuadmin.webmin/tasks/main.yml` in this .yml file we have to change our `ansible_0s_family` arggument in the Add yum repository section. From Debian to Rocky.

An Ansible playbook is a `.yml` that contains directions and plays that ansible will follow.

Our `webmin.yml` playbook look like:
```
---
- name: webmin SYS265
  hosts: webmin
  become: true
  vars:
    install_utilities: false firewalld_enable: true
roles:
- semuadmin.webmin

tasks:
- name: add firewall rule
firewalld
  port: 10000/tcp
  permanent: true
  state: enabled
```
A succsessful execution of this playbook will install webmin on our RockyOS box
```
