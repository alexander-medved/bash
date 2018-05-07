#!/bin/bash

file=/tmp/file.txt;
percload=50
server='dbmsrv'

LINES=`wc -l $file | cut -d" " -f 1`;

cond=`ansible $server -m raw -a "docker stats --no-stream redis | grep redis > /tmp/cpu; cut -c21-24 /tmp/cpu" -o | awk '{print $8;}' | cut -b -4`

if  [ "$LINES" -ge 10 ];
then
	ex -sc '1d1|x' $file
else
	echo "we need more than $LINES in $file"
fi

echo $cond >> $file

if [ -s "$file" ]
then
	echo "The $file exists and we can run sometsing alse"
	average=$(cat $file | awk '{if(min==""){min=max=$1}; if($1>max) {max=$1}; if($1<min) {min=$1}; total+=$1; count+=1} END {print total/count}');
	ave=$( echo $average | awk '{printf "%.0f\n",$1}' );
	if [ "$ave" -ge "$percload" ];
	then
		echo "$ave% is hevy loading lets flashall sessions"
		docker exec redis redis-cli -h $server -p 6379 flushall;
		echo "1" > $file;

	else
		echo "Redis is not so heavy loaded than $percload%, only $ave"
	fi
else
	echo "$file does not exist, or is empty"
fi
exit 0;
