#!/bin/bash

#echo "installing soft on master"
./install.sh
#echo "reading file and registrating pub key on dst OS"
./setup.sh
#echo "configuring ansible hosts file"
./hosts.sh
