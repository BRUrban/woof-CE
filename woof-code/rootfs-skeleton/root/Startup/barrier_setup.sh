#!/bin/bash

source $HOME/.config/barrier.cfg

##This part ensures ethernet comes up automatically
# Find our NIC device.
NIC=$(ifconfig  -a | grep eth|awk {'print $1'}) # gives us lowest numbered eth? adapter

# Bounce NIC device
ifconfig $NIC down
ifconfig $NIC up

#Wait until eth0 is up to proceed. (Assumes ethernet connection, will need to adjust if using wifi)
until [ $(cat /sys/class/net/eth0/operstate) == "up" ]
do
  sleep 10
done

##This part runs the actual barrier setup stuff
# Generate appropriate-format fingerprints
$HOME/.barrier/barrierc-trust.sh $BARRIER_SERVER

# Start barrier client
$HOME/.barrier/barrier-client.sh