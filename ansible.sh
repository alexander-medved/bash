#!/bin/bash

Hosts=${PWD}/hosts
Ar=https://www.dropbox.com/s/qzfs9xtn22flxw/bash.zip
Ans="ansible tst_group"

if [ ! -f $Hosts ]; then
    echo "the $Hosts not found!"
fi

export ANSIBLE_INVENTORY=$Hosts
#$Ans -m setup -a "filter=ansible_local"
$Ans -vv -m raw -a "cd /; tar -czvf opt.tar.gz /opt"
$Ans -vv -m raw -a "cd /opt; rm -rf /opt/bash; wget -qO- -O tmp.zip $Ar && unzip tmp.zip && rm tmp.zip"
echo "deploying by bash scripts"
$Ans -vvv -m raw -a "cd /opt; chmod +x ./bash/*.sh; mv ./bash/* ./; mkdir -p /opt/bsom/libs"
$Ans -vvv -m raw -a "cd /opt; ./install.sh"
$Ans -m raw -a "ls -la /opt/bsom/libs; rm -rf /opt/bash"
#history -r
