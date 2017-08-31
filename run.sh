#!/bin/bash

# intalling soft on master
./install.sh
# reading file and registrating pub key on dst OS
./setup.sh
# configuring ansible hosts file
./hosts.sh
# running play-book to deploy project on dst OS
./ansible.sh
# run
