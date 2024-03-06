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
We need to now update our sudoers

etc
└── sudoers.d
    └── sys265
