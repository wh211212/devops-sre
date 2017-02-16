#!/bin/bash
##########################################################################
# Script Name: remote_deploy_service.sh
# Author: shaon
# Email: shaonbean@qq.com
# Created Time: Thu 22 Dec 2016 11:59:59 AM CST
#########################################################################
# Blog address: http://blog.csdn.net/wh211212
#########################################################################
# Functions: remote deploy service use remote script
#
# Changelog:
# 2016-12-22   wanghui    initial
# 2017-02-14   wanghui    optimization
######################################
# Define some variables
Date=$(date +%F_%T)
Remote_Script=/data/script/deploy-api.sh
Remote_User=root
Remote_Port=54077
########################################################################
Version_Num=2016-12-22
########################################################################
#            Remote deploy aniu api                                    #
########################################################################
#
aniuapi() {
	# define variables
	echo "*************************************************************"
	echo "***   begin remote deploy aniu api service.   ***"
    for host in 192.168.0.25 192.168.0.37
    do
        Remote_Script=/data/script/deploy-aniuapi.sh
    	/usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_Script''
    	if [ $? -eq 0 ];then
    	    echo "***  Remote $host deploy script execute succeed!***"
            echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_correctly.log
    	else
            echo "***  Remote deploy script execute failed! ***"
            echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_incorrect.log
            exit 0
    	fi
    done
}

########################################################################
#            Remote deploy aniu api                                    #
########################################################################
#
wxapi() {
	# define variables
	echo "*************************************************************"
	echo "***   begin remote deploy wx api service.   ***"
    for host in 192.168.0.4 192.168.0.9
    do
    	/usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_Script''
    	if [ $? -eq 0 ];then
    	    echo "***  Remote deploy script execute succeed!***"
            echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_correctly.log
    	else
            echo "***  Remote deploy script execute failed! ***"
            echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_incorrect.log
            exit 0
    	fi
    done
}

########################################################################
#              Remote deploy zjt api                                    #
########################################################################
#
zjtapi() {
	# define variables
	echo "*************************************************************"
	echo "***   begin remote deploy zjt api service.   ***"
    for host in 192.168.0.18 192.168.0.41
    do
    	/usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_Script''
    	if [ $? -eq 0 ];then
    	    echo "***  Remote deploy script execute succeed!***"
            echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_correctly.log
    	else
       	    echo "***  Remote deploy script execute failed! ***"
            echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_incorrect.log
            exit 0
    	fi
    done
}

########################################################################
#             Remote deploy njdz api                                    #
########################################################################
#
njdxapi() {
	# define variables

	echo "*************************************************************"
	echo "***   begin remote deploy njdx api service.   ***"
    for host in 192.168.0.25 192.168.0.37
    do
        Remote_Script=/data/script/deploy-njdxapi.sh
    	/usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_Script''
    	if [ $? -eq 0 ];then
    	    echo "***  Remote deploy script execute succeed!***"
            echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_correctly.log
    	else
            echo "***  Remote deploy script execute failed! ***"
            echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_incorrect.log
            exit 0
    	fi
    done
}

########################################################################
#            Remote deploy user api                                    #
########################################################################
#
userapi() {
	# define variables

	echo "*************************************************************"
	echo "***   begin remote deploy userapi api service.   ***"
    for host in 192.168.0.6 192.168.0.11 192.168.0.79
    do
    	/usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_Script''
    	if [ $? -eq 0 ];then
    	    echo "***  Remote deploy script execute succeed!***"
            echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_correctly.log
    	else
    	    echo "***  Remote deploy script execute failed! ***"
            echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_incorrect.log
            exit 0
    	fi
    done
}

########################################################################
#            Remote deploy aniu admin service                          #
########################################################################
#
aniuadmin() {
  # define variables

  echo "*************************************************************"
  echo "***   begin remote deploy aniu admin service.   ***"
    for host in 192.168.0.8
    do
      Remote_aniuadmin=/data/script/deploy_aniu_admin.sh
      /usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_aniuadmin''
      if [ $? -eq 0 ];then
          echo "***  Remote deploy script execute succeed!***"
          echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_correctly.log
      else
          echo "***  Remote deploy script execute failed! ***"
          echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_incorrect.log
          exit 0
      fi
    done
}


########################################################################
#            Remote deploy aniu mmsadmin service                       #
########################################################################
#
mmsadmin() {
  # define variables

  echo "***********************************************************"
  echo "***        begin remote deploy mmsadmin service.        ***"
    for host in 192.168.0.8
    do
      Remote_mmsadmin=/data/script/deploy_mmsadmin.sh
      /usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_mmsadmin''
      if [ $? -eq 0 ];then
          echo "***  Remote deploy script execute succeed!***"
          echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_correctly.log
      else
          echo "***  Remote deploy script execute failed! ***"
          echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_incorrect.log
          exit 0
      fi
    done
}


########################################################################
#            Remote deploy aniu crm admin                              #
########################################################################
#
crmadmin() {
  # define variables

  echo "*************************************************************"
  echo "***   begin remote deploy crm admin  service.   ***"
    for host in 192.168.0.8
    do
      Remote_crmadmin=/data/script/deploy_crm_admin.sh
      /usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_crmadmin''
      if [ $? -eq 0 ];then
          echo "***  Remote deploy script execute succeed!***"
          echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_correctly.log
      else
          echo "***  Remote deploy script execute failed! ***"
          echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_incorrect.log
          exit 0
      fi
    done
}

########################################################################
#            Remote deploy aniu crm api service                        #
########################################################################
#
crmapi() {
  # define variables

  echo "*************************************************************"
  echo "***   begin remote deploy crm api service.   ***"
    for host in 192.168.0.73 192.168.0.65
    do
      Remote_crmapi=/data/script/deploy_crm_api.sh
      /usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_crmapi''
      if [ $? -eq 0 ];then
          echo "***  Remote deploy script execute succeed!***"
          echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_correctly.log
      else
          echo "***  Remote deploy script execute failed! ***"
          echo "***  Remote ${Date} ${host} deploy script execute succeed!***" >> /data/script/deploy_service_incorrect.log
          exit 0
      fi
    done
}

########################################################################
#            Remote deploy niuke api service                       #
########################################################################
#
niukeme() {
  # define variables
  echo "***********************************************************"
  echo "***        begin remote deploy niuke api service.        ***"
    for host in 192.168.0.80 192.168.0.81
    do
      Remote_mmsadmin=/data/script/deploy-nkm-api.sh
      /usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_mmsadmin''
      if [ $? -eq 0 ];then
          echo "***  ${hosts} Remote deploy script execute succeed!***"
      else
          echo "***  ${hosts} Remote deploy script execute failed! ***"
            exit 0
      fi
    done
}

#######################################################################
#            Remote deploy niuke api task service                       #
########################################################################
#
niukeme-task() {
  # define variables

  echo "***********************************************************"
  echo "***       begin remote deploy niukeme-task service.     ***"
    for host in 192.168.0.78
    do
      Remote_mmsadmin=/data/script/deploy_nkm-api-task.sh
      /usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_mmsadmin''
      if [ $? -eq 0 ];then
          echo "***  ${hosts} Remote deploy script execute succeed!***"
      else
          echo "***  ${hosts} Remote deploy script execute failed! ***"
          exit 0
      fi
    done
}


#######################################################################
#            Remote deploy niuke admin  service                       #
########################################################################
#
nkm-admin() {
  # define variables

  echo "***********************************************************"
  echo "***       begin remote deploy niukeme-admin service.    ***"
    for host in 192.168.0.8
    do
      Remote_mmsadmin=/data/script/deploy_nkm_admin.sh
      /usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_mmsadmin''
      if [ $? -eq 0 ];then
          echo "***  ${hosts} Remote deploy script execute succeed!***"
      else
          echo "***  ${hosts} Remote deploy script execute failed! ***"
          exit 0
      fi
    done
}

########################################################################
#            Remote deploy product api task service                       #
########################################################################
#
product-api() {
  # define variables

  echo "***********************************************************"
  echo "***        begin remote deploy product api service.        ***"
    for host in 192.168.0.6 192.168.0.34
    do
      Remote_mmsadmin=/data/script/deploy_api_product.sh
      /usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_mmsadmin''
      if [ $? -eq 0 ];then
          echo "***  ${hosts} Remote deploy script execute succeed!***"
      else
          echo "***  ${hosts} Remote deploy script execute failed! ***"
          exit 0
      fi
    done
}

########################################################################
#            Remote deploy product service                             #
########################################################################
#
product-service() {
  # define variables

  echo "***********************************************************"
  echo "***        begin remote deploy product service.        ***"
    for host in 192.168.0.8
    do
      Remote_mmsadmin=/data/script/deploy_service_product.sh
      /usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_mmsadmin''
      if [ $? -eq 0 ];then
          echo "***  ${hosts} Remote deploy script execute succeed!***"
      else
          echo "***  ${hosts} Remote deploy script execute failed! ***"
          exit 0
      fi
    done
}

########################################################################
#            Remote deploy product service                             #
########################################################################
#
message-channel() {
  # define variables

  echo "***********************************************************"
  echo "***        begin remote deploy message channel service.        ***"
    for host in 192.168.0.38 192.168.0.40
    do
      Remote_mmsadmin=/data/script/deploy_message-channel.sh
      /usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_mmsadmin''
      if [ $? -eq 0 ];then
          echo "***  ${hosts} Remote deploy script execute succeed!***"
      else
          echo "***  ${hosts} Remote deploy script execute failed! ***"
          exit 0
      fi
    done
}

########################################################################
#            Remote deploy stock api service                             #
########################################################################
#
stock() {
  # define variables

  echo "***********************************************************"
  echo "***        begin remote deploy stock api service.        ***"
    for host in 192.168.0.27 192.168.0.40
    do
      Remote_mmsadmin=/data/script/deploy_stock-api.sh
      /usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_mmsadmin''
      if [ $? -eq 0 ];then
          echo "***  ${hosts} Remote deploy script execute succeed!***"
      else
          echo "***  ${hosts} Remote deploy script execute failed! ***"
          exit 0
      fi
    done
}

########################################################################
#            Remote deploy stock api service                             #
########################################################################
#
algoquote-admin() {
  # define variables

  echo "***********************************************************"
  echo "***        begin remote deploy stock api service.        ***"
    for host in 192.168.0.160
    do
      Remote_mmsadmin=/data/script/deploy_algoQuote_admin.sh
      /usr/bin/ssh -p $Remote_Port $Remote_User@$host ''$Remote_mmsadmin''
      if [ $? -eq 0 ];then
          echo "***  ${hosts} remote execute deploy script execute succeed!***"
      else
          echo "***  ${hosts} Remote deploy script execute failed! ***"
          exit 0
      fi
    done
}

#################################################################################################
# Script common functions
#################################################################################################

help() {
  echo "*******************************"
  # print_version
  echo "*******************************"
  printf "Usage: %s: [-i] [-w] [-z] [-j] [-u] [-I] [-M] [-N] [-c] [-C] [-k] [-T] [-K] [-p] [-P] [-m] [-s] [-G] args" $(basename $0)
  printf "\n
  -h -- display this script functions and options
  -i -- remote deploy aniu api & check aniu api status
  -w -- remote deploy wx api & check wx api status
  -z -- remote deploy zjt api & check zjt api status
  -j -- remote deploy njdx api & check njdx api status
  -u -- remote deploy usr api & check user api status
  -I -- remote deploy aniu admin & check admin status
  -M -- remote deploy mmsadmin & check mmsadmin status
  -N -- remote deploy adminivntv  & check icvtv status
  -C -- remote deploy aniu crm admin & check crm-admin status 
  -c -- remote deploy aniu crm api & check crm-api status
  -k -- remote deploy niukeme api & check niukeme status
  -T -- remote deploy niukeme task & check nkm task status
  -K -- remote deploy niukeme admin & check nkm admin status
  -p -- remote deploy product api & check product api status
  -P -- remote deploy product service & check product service status
  -m -- remote deploy message-channel & check message channel status
  -s -- remote deploy stock api & check stock api status
  -G -- remote deploy algoquote admin & check algoquote admin status \n\n"
}

# display version number
#print_version() {
#  printf "Version: %s\n" $Version_Num
#   echo "***   Version: $Version_Num   ***"
#}
# get options to play with and define the script behavior
get_options() {
  while getopts 'hiwzjuIMNcCkTKpPmsG' OPTION;
  do
    case "$OPTION" in
      h)    help
            exit 0
            ;;
      i)    aniuapi
            ;;
      w)    wxapi 
            ;;
      z)    zjtapi
            ;;
      j)    njdxapi  
            ;;        
      u)    userapi  
            ;;        
      I)    aniuadmin
            ;;        
      M)    mmsadmin
            ;;        
      N)    adminicntv
            ;;        
      C)    crmadmin
            ;;        
      c)    crmapi
            ;;
      k)    niukeme
            ;;
      T)    niukeme-task
            ;;
      K)    niukeme-admin
            ;;
      p)    product-api
            ;;
      P)    product-service
            ;;
      m)    message-channel
            ;;
      s)    stock
            ;;
      G)    algoquote-admin
            ;;
      ?)    help >&2
            exit 2
            ;;
  esac
    # if a parameter entered by the user is '-'
    if [ -z "$OPTION" ]; then
    echo -e "$RED ERROR: Invalid option entered $NO_COLOR" >&2
      help >&2
      exit 2
    fi
  done
}

# check that at least one parameter has been added when lauching the script
if [ -z "$@" ]; then
  help >&2
  exit 2
fi

parameter=`echo "$@" | awk '{print substr($0,0,1)}'`
if [ "$parameter" != "-" ]; then
  help >&2
  exit 2
fi

### get options
get_options "$@"
