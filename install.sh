#!/bin/bash
APT=/usr/bin/apt-get
#
$APT install software-properties-common -y
apt-add-repository ppa:ansible/ansible
$APT update
$APT install ansible sshpass -y

