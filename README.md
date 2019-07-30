# Vagrantfiles
Vagrantfiles and scripts used to set up and test various applications.

## `bind`
An example of a single-master, dual-slave BIND DNS setup.

| VM Name  | OS           | Role              | IP             |
|----------|--------------|-------------------|----------------|
| ns01     | Ubuntu 18.04 | Master nameserver | 192.168.33.105 |
| ns02     | Ubuntu 18.04 | Slave nameserver  | 192.168.33.106 |
| ns03     | Ubuntu 18.04 | Slave nameserver  | 192.168.33.107 |

## `devstack`
An environment to test out OpenStack using the DevStack scripts.

| VM Name  | OS           | Role          | IP             |
|----------|--------------|---------------|----------------|
| devstack | Ubuntu 18.04 | DevStack host | 192.168.33.104 |

## `graylog-test`
A simple test of Graylog with a single Graylog server and a Postfix server

| VM Name | OS           | Role    | IP             |
|---------|--------------|---------|----------------|
| graylog | Ubuntu 16.04 | Graylog | 192.168.33.102 |
| mail    | Ubuntu 16.04 | Postfix | 192.168.33.103 |

## `openstack`
A testing environment modeled to closely replicate the RITSEC Cloud
infrastructure. For more information, see the [README](./openstack/README.md)

| VM Name | OS           | Role       |
|---------|--------------|------------|
| mgmt01  | Ubuntu 18.04 | Controller |
| mgmt02  | Ubuntu 18.04 | Controller |
| mgmt03  | Ubuntu 18.04 | Controller |
| nova01  | Ubuntu 18.04 | Compute    |
| nova02  | Ubuntu 18.04 | Compute    |
| nova03  | Ubuntu 18.04 | Compute    |
| stor01  | Ubuntu 18.04 | Ceph OSD   |
| stor02  | Ubuntu 18.04 | Ceph OSD   |
| stor03  | Ubuntu 18.04 | Ceph OSD   |

## `redmine-db-cluster`
A multi-VM installation of Redmine with MariaDB clustering and an NGINX proxy

| VM Name | OS       | Role        | IP             |
|---------|----------|-------------|----------------|
| app01   | CentOS 7 | Redmine     | 192.168.33.110 |
| db01    | CentOS 7 | Galera node | 192.168.33.111 |
| db02    | CentOS 7 | Galera node | 192.168.33.112 |
| db03    | CentOS 7 | Galera node | 192.168.33.113 |
| prx01   | CentOS 7 | Proxy       | 192.168.33.114 |

## `redmine-small`
A single-VM installation of Redmine

| VM Name | OS       | Role    | IP             |
|---------|----------|---------|----------------|
| redmine | CentOS 7 | Redmine | 192.168.33.101 |
