#!/bin/bash -xv
TEMP_ON_HDD=/mnt/san300logs/ramdisk-backup
MP_RAM_DISK=/mnt/ramdisk
SERVICE=/etc/rc.d/init.d/ramdisk
crontab -l | grep -lq  "$SERVICE"
FIND_ST=$?

# check if we have the folder on the right HDD for backup
if [ ! -d $TEMP_ON_HDD ]; then
  mkdir -p $TEMP_ON_HDD;
fi

# check if we have right mount point for disk in RAM
if [ ! -d $MP_RAM_DISK ]; then
  mkdir -p $MP_RAM_DISK;
fi

crontask(){
        if [ $FIND_ST -eq 0 ]; then
                echo "The service $SERVICE in crontab already scheduled!"
                exit 2
        else
                #write out current crontab
                crontab -l > mycron
                #echo new cron into cron file
                echo "* * * * * bash $SERVICE sync >> /dev/null 2>&1" >> mycron
                #install new cron file
                crontab mycron
                rm mycron
        fi

}

if [ ! -f ./ramdisk ]; then
	echo "The file ./ramdisk has no found!"
	exit 2
else
	if [ ! -f $SERVICE ]; then
  		cp ./ramdisk $SERVICE;
		chmod +x $SERVICE;
		chkconfig --level 345 ramdisk on;
		chkconfig crond on;
		crontask;
		echo "The service just been installed here: /etc/rc.d/init.d/ramdisk"
		echo "but you need to create the disk in memory by tmpfs and switch-on it in fstab:"
		echo "echo 'tmpfs           /mnt/ramdisk tmpfs      defaults,size=32768M    0 0' >> /etc/fstab"
		echo "next you should create task for logrotate"
	else
        	echo "The service has been installed!"
		exit 2
	fi
fi
