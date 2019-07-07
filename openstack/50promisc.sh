#!/bin/bash

if [ ${IFACE} == "bond-mgmt" ]
then
    ip link set bond-mgmt promisc on
fi