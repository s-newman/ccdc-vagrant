OpenStack
=========

A testing environment modeled to closely replicate the RITSEC Cloud
infrastructure. This was initially created to assist with testing
OpenStack-Ansible deployments during the initial setup of the RITSEC Cloud.

The intention of this environment is to model as closely as possible the
physical setup of the RITSEC Cloud infrastructure to eliminate as many
variables as possible between testing and production. In theory, the RITSEC
fork of the OpenStack-Ansible code should be completely compatible between the
production environment and a testing environment set up with this project.

Usage
-----

Before you can set up your own testing environment, you need to install
Ansible, Vagrant, and VirtualBox. Yes, specifically VirtualBox. This
Vagrantfile is not compatible with any Vagrant providers other than VirtualBox.
Installing these programs is left as an exercise to the reader.

Once these programs have been installed and this repository has been
cloned/downloaded/otherwise obtained in a legitimate way, you can get started.
Run the following commands to prepare the environment:

```sh
vagrant up
ansible-playbook playbook.yml -i inventory.ini
```

This setup will take quite a long time. The `Set up ceph` task can take an
especially long time, so don't worry if it appears to be timing out. Take a
look at the `ceph-setup.sh` script to see how much work that one task is doing.

**Please note** that a total of **30 GB of RAM** and **24 vCPUs** will be
allocated across the nine VMs. At idle, this environment has been seen to
consume around 6-8 GB of RAM on its own. Please make sure to properly configure
sufficient memory and swap space before attempting to create a copy of this
environment. CPU usage is typically not affected too harshly during idle, but
intensive workloads (such as the Ansible playbook) can have a significant
impact on the host device. The environment has been seen to result in a UNIX
CPU load average of over 8 at some points during the execution of the
`ansible-playbook` command.

Once the setup is complete, run the following commands to log in and switch to
the `ops` user:

```sh
vagrant ssh mgmt01

# This will be run after logging into mgmt01
sudo su ops
```

This two-step login is necessary because Vagrant boxes have a default user of
`vagrant`, while the RITSEC Cloud uses `ops` as the default user.
