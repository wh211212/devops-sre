#!/bin/bash
##################################################################################################
#    Description:
#    - check cpu load
#    crontab: */5 * * * * /home/deploy/scripts/check_cpu_load.sh >> /var/log/os/check_cpu_load.log
##################################################################################################
#    CHANGELOG
#    History
#    2016-05-09      www.vdevops.com    First version release
##################################################################################################
#       set variable
##################################################################################################

TOP_SYS_LOAD_NUM=3
SYS_LOAD_NUM=`uptime | awk '{print $(NF-2)}' | sed 's/,//'`

echo $(date +"%y-%m-%d") `uptime`
if [ `echo "$TOP_SYS_LOAD_NUM < $SYS_LOAD_NUM" | bc` -eq 1 ]
then
echo "#0#" $(date +"%y-%m-%d %H:%M:%S") "pkill httpd" `ps -ef | grep httpd | wc -l` >> /usr/local/apache/check_cpu_load.log
/usr/local/apache/bin/apachectl stop
sleep 5
pkill httpd
sleep 5
for i in 1 2 3
do
if [ `pgrep httpd | wc -l` -le 0 ]
then
/usr/local/apache/bin/apachectl start
sleep 30
echo "#1#" $(date +"%y-%m-%d %H:%M:%S") "start httpd" `ps -ef | grep httpd | wc -l` >> /usr/local/apache/check_cpu_load.log
fi
done
else
if [ `pgrep httpd | wc -l` -le 0 ]
then
/usr/local/apache/bin/apachectl start
sleep 30
echo "#2#" $(date +"%y-%m-%d %H:%M:%S") "start httpd" `ps -ef | grep httpd | wc -l` >> /usr/local/apache/check_cpu_load.log
fi
fi
