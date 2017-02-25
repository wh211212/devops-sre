#!/bin/bash
############################################################
# Functions: check tomcat service status 
#
# Changelog:
# 2016-07-04    wh       initial commit
# 2017-02-24    wanghui  add if
# 
############################################################
#
Date=`date +%F_%T`
#
for port in 8082 8083 8084
do
tomcat_port=tomcat_$port
tomcat_dir=/data

# info 
echo "*** begin check $tomcat_port status ***!"
# get the tomcat process id
tomcatid_num=$(ps -ef | grep $tomcat_port | grep "[o]rg.apache.catalina.startup.Bootstrap start" | grep -v 'grep'| awk '{print $2}' | wc -l)

tomcatid=$(ps -ef | grep $tomcat_port | grep "[o]rg.apache.catalina.startup.Bootstrap start" | grep -v 'grep'| awk '{print $2}')


# tomcat startup procedure (here tomcat the actual installation path)
tomcatstart=$tomcat_dir/$tomcat_port/bin/startup.sh
tomcatcache=$tomcat_dir/$tomcat_port/work

# the definition should be monitoring the page address 
# ip=`ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`
ip=`ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}' | awk 'NR==1{print}'`
# check url

api_url="http://$ip:$port//aniuapi/api/v2/video/commend?channelid=100211&clienttype=2&devid=800001&pno=1&productid=004&psize=3&time=20151110141945&type=2&sign=51c2e405b3e808256e209a9f44a35058"
echo "checK url: $api_url"
# the log output
tomcat_monitor_log=$tomcat_dir/$tomcat_port/logs/tomcat_monitor.log

monitor()
{
    echo "[Info]to monitor tomcat...[$(date +'%F %T')]!"
  if [ $tomcatid_num -eq 1 ];then                                     
    # here to judge tomcat process exists
    echo "[Info] the current tomcat process id: $tomcatid, continue to test page..."

    # to detect whether the launch success (succeed page returns the state "200")
    status_code=`curl -o /dev/null -m 10 --connect-timeout 10 -s -w %{http_code} $api_url`

    if [ $status_code -eq 200 ];then
      echo "[Info]the page code $status_code, tomcat started successfully, the normal test page......"
    else
      echo "[ERROR]tomcat test page, please note... with status code $status_code, the error log is output to the /dev/null"
      echo "[ERROR]the page access error, restart tomcat"
      kill -9 $tomcatid                                                # kill the tomcat process
      sleep 3
      rm -rf $tomcatcache                                              # clean up the tomcat cache
    $tomcatstart
   fi
  else
    echo "[ERROR] the tomcat process does not exist! tomcat automatic restart..."
    echo "[Info] $tomcatstart,please wait for a while......"
    rm -rf $tomcatcache
    $tomcatstart
  fi
   echo "------------------------------"
echo "*** end check $tomcat_port status ***!"
}

# main
monitor
monitor >> $tomcat_monitor_log

done


# 注，当tomcatid不等于1时，会有两种情况，等于0 或者大于1