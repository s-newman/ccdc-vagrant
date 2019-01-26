# ccdc-vagrant
Vagrantfiles used for CCDC preparation

## `redmine-small`
A single-VM installation of Redmine

| VM Name | OS       | Role    | IP              |
|---------|----------|---------|-----------------|
| redmine | CentOS 7 | Redmine | 192.168.33.101  |

## `redmine-db-cluster`
A multi-VM installation of Redmine with MariaDB clustering and an NGINX proxy

| VM Name | OS       | Role        | IP              |
|---------|----------|-------------|-----------------|
| app01   | CentOS 7 | Redmine     | 192.168.33.110  |
| db01    | CentOS 7 | Galera node | 192.168.33.111  |
| db02    | CentOS 7 | Galera node | 192.168.33.112  |
| db03    | CentOS 7 | Galera node | 192.168.33.113  |
| prx01   | CentOS 7 | Proxy       | 192.168.33.114  |

## `clients`
| VM Name | OS            | Role    | IP              |
|---------|---------------|---------|-----------------|
| trav    | lubuntu 18.10 | Client  | 192.168.33.120  |
| util01  | FreeBSD 11.1  | Utility | 192.168.33.121  |
| util02  | Ubuntu 18.10  | Utility | 192.168.33.122  |