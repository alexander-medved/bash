#!/bin/bash

Hosts=${PWD}/hosts
Ar=https://www.dropbox.com/s/kxfiisycuext9wc/bash.zip
Ans="ansible tst_group"

if [ ! -f $Hosts ]; then
    echo "the $Hosts not found!"
fi

export ANSIBLE_INVENTORY=$Hosts
#$Ans -m setup -a "filter=ansible_local"
$Ans -m raw -a "rm -rf ~/bash; wget -qO- -O tmp.zip $Ar && unzip tmp.zip && rm tmp.zip"
echo "deploying by scripts from install.sh"
$Ans -vvv -m raw -a "cd ~/bash; chmod +x *.sh; mkdir -p /opt/bsom/libs; ./install.sh"
$Ans -m raw -a "ls -la /opt/bsom/libs"
#history -r
