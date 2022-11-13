#!/bin/bash

source $HOME/.config/barrier.cfg

##This part just ensures ethernet comes up automatically
# Find our NIC device.
#
NIC=$(ifconfig  -a | grep eth|awk {'print $1'}) # gives us lowest numbered eth? adapter

# Bounce NIC device
ifconfig $NIC down
ifconfig $NIC up

##This part runs the actual barrier setup stuff
# Generate appropriate-format fingerprints
$HOME/.barrier/barrierc-trust.sh $BARRIER_SERVER

# Start barrier client
$HOME/.barrier/barrier-client.sh