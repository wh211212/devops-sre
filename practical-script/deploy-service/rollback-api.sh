#!/bin/bash
##########################################################################
# Script Name: rollback_api.sh
# Author: shaon
# Email: shaonbean@qq.com
# Created Time: Tue 20 Dec 2016 07:56:59 PM CST
#########################################################################
# Blog address: http://blog.csdn.net/wh211212
#########################################################################
# Define some variables #
Date=`date +%F_%T`
DATE=`date +Y-%m-%d`
Project=aniuapi
Back_dir=/data/war_back/$Project
Wget_dir=/data/wget

# Move to Back_dir watch which time deploy you want Rollback
echo "-----------------------------------------------------"
echo "  Three last deploy version "
ls -ltr $Back_dir | tail -3 > /tmp/version.txt
cat /tmp/version.txt
read -p "which version war you want rollback: " version

# Begin rollback all api
echo "-----------------------------------------------------"
echo "----       Begin rollback all api!               ----"
echo "-----------------------------------------------------"
# Copy need rollback api.war to wget_dir
  /bin/cp -f $Back_dir/$version $Wget_dir/$Project.war

  for port in 8082 8083 8084
    do
    Tomcat_port=tomcat_$port
    Project_home=/data/$Tomcat_port
    Project_dir=$Project_home/webapps
  #  echo "*** First step shutdown $Tomcat_port ***"
    /bin/bash $Project_home/bin/shutdown.sh
    tomcat_status=`ps -ef | grep $Tomcat_port | grep -v grep | awk '{print $2}' | wc -l`
    if [ $tomcat_status -eq 0 ];then
         echo "*** $Tomcat_port auto shutdown succeed!  ***"
      else
  #       echo "*******************************************************************************"
  #       echo "*** $Tomcat_port auto shutdown failed,then should force shutdown $Tomcat_port! " 
         ps -ef | grep $Tomcat_port | grep -v grep | awk '{print $2}' | xargs kill -9
         tomcat_pid=`ps -ef | grep $Tomcat_port | grep -v grep | awk '{print $2}'`
         /bin/kill -9 tomcat_pid
    fi
    /bin/rm -rf $Project_dir/$Project*
    /bin/cp $Wget_dir/$Project.war $Project_dir/
    /bin/bash $Project_home/bin/startup.sh
  #  echo "-----------------------------------------------------------------------------------"
    tomcat_pid=`ps -ef | grep $Tomcat_port | grep -v grep | awk '{print $2}'`
    if [ $tomcat_pid -ne 0 ];then
       echo "*****************************************************"
       echo "***      $Tomcat_port auto rollback succeed !     ***"
       echo "******************************************************"
    else
       echo "### $Tomcat_port auto rollabck failed! #####"
       echo "#############################################"
    fi
  done 
#
rm -f /tmp/version.txt
