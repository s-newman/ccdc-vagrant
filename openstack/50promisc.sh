#!/bin/bash

if [ ${IFACE} == "bond-mgmt" ]
then
    ip link set bond-mgmt promisc on
fi
if [ ${IFACE} == "bond-storage" ]
then
    ip link set bond-storage promisc on
fi