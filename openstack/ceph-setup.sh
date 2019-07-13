#!/bin/bash
# This should be run on mgmt01 ONLY

# Preflight
wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -
echo deb https://download.ceph.com/debian-nautilus/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
sudo apt-get update && sudo apt-get install -y ceph-deploy

cat >> ~/.ssh/config << EOF
Host *
    StrictHostKeyChecking no
EOF

# start yer engines
mkdir ritsec-ceph
cd ritsec-ceph
ceph-deploy new mgmt01 mgmt02 mgmt03

cat > ceph.conf << EOF
[global]
fsid = abadeb03-6204-4b81-81b2-e7ff97316c61
mon_initial_members = mgmt01, mgmt02, mgmt03
mon_host = 10.0.9.201, 10.0.9.202, 10.0.9.203
public network = 10.0.9.0/24
auth_cluster_required = cephx
auth_service_required = cephx
auth_client_required = cephx
EOF

ceph-deploy install mgmt01 mgmt02 mgmt03
ceph-deploy mon create-initial
ceph-deploy admin mgmt01 mgmt02 mgmt03
ceph-deploy mgr create mgmt01 mgmt02 mgmt03
ceph-deploy install stor01 

# oh ess DICK
ceph-deploy osd create --data /dev/sdc stor01
ceph-deploy osd create --data /dev/sdd stor01
ceph-deploy osd create --data /dev/sde stor01
ceph-deploy osd create --data /dev/sdc stor02
ceph-deploy osd create --data /dev/sdd stor02
ceph-deploy osd create --data /dev/sde stor02
ceph-deploy osd create --data /dev/sdc stor03
ceph-deploy osd create --data /dev/sdd stor03
ceph-deploy osd create --data /dev/sde stor03

# Clients
ceph-deploy install nova01 nova02 nova03
ceph-deploy admin nova01 nova02 nova03