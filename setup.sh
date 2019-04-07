#!/bin/bash
-e

PaFile=$PASS
PubKey=~/.ssh/id_rsa.pub

if [ ! -f $PaFile ]; then
    echo "the $PaFile not found!"
fi
if [ ! -f $PubKey ]; then
    echo "the $PubKey not found! pleace cd ~/.ssh; and run ssh-keygen"
exit
fi

#apt-get install sshpass -y

declare -a MYARR=(`cat $PaFile`);
 
    for i in "${MYARR[@]}"; do
	a=($(echo $i | cut -d":" -f1))
	p=($(echo $i | cut -d":" -f2))
        echo "$a" and "$p";
	ssh-keyscan $a >> ~/.ssh/known_hosts;
	sshpass -p $p ssh-copy-id -i $PubKey root@$a;
    done;

#history -r
