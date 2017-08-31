#!/bin/bash

PaFile=./pass_file.txt
Hosts=${PWD}/hosts
Ans="ansible tst_group"

if [ ! -f $PaFile ]; then
    echo "the $PaFile not found!"
fi

touch $Hosts
echo "[tst_group]" >> $Hosts

declare -a MYARR=(`cat $PaFile`);
 
    for i in "${MYARR[@]}"; do
	a=($(echo $i | cut -d":" -f1))
	echo $a >> $Hosts;
    done;
export ANSIBLE_INVENTORY=$Hosts
$Ans -m ping

#history -r
