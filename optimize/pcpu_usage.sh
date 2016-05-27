#!/bin/bash
############################################
# Functions:计算一个小时内进程的CPU使用情况
# 
############################################
#
SECS=3600
UNIT_TIME=60
#UNIT_TIME是取消的时间间隔，单位是秒
#
Steps=$(( $SECS / $UNIT_TIME ))

echo "Watching cpu Usage...";
for ((i=0;i<Steps;i++))
do
	ps -eo comm,pcpu | tail -n +2 >> /tmp/cpu_usage.$$
	sleep $UNIT_TIME
done

echo
echo CPU eaters :
cat /tmp/cpu_usage.$$ | \
awk '
{ process[$1]+=$2; }
END{
	for ( i in process )
	{
		printf("%-20s %s",i,process[i]);
	}
}
' | sort -nrk 2 | head
rm /tmp/cpu_usage.$$
