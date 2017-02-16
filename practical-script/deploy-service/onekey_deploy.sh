#!/bin/bash
##########################################################################
# Script Name: onekey_deploy.sh
# Author: shaon
# Email: hwang@aniu.tv
# Created Time: Tue 14 Feb 2017 05:19:19 PM CST
#########################################################################
# Blog address: http://blog.csdn.net/wh211212
#########################################################################
# Functions: Automatic deployment package #
# ChangeLog:
# 2017-02-14 wanghui initial create  
########################################################################
# Define some variables:  #
# 
Date=`date +%F_%T`
mvn_script=/data/script/mvn_deploy_project.sh
deploy_script=/data/script/remote_execute_deploy.sh
onekey_deploy_log=/data/script/auto/remote_onekey_deploy.log
#
#######################################################################
#
# Local package remote deployment,
######################################################################
# onekey deploy aniuapi
aniuapi(){
  echo "*** Begin onekey deploy aniu api service! ***"
  /bin/bash $mvn_script -i 

  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -i   
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi

#    if [ $? -eq 0 ];then
#        echo "*************************************************"
#        echo "***　　　aniuapi onekey deploy succeed!       ***"
#        echo "*************************************************"
#        echo "***  $Date onekey deploy aniuapi succeed!  ***" >> $onekey_deploy_log
#    else
#        echo "*************************************************"
#        echo "***　　　aniuapi onekey deploy failed!        ***"
#        echo "*************************************************"
#        echo "***  $Date onekey deploy aniuapi failed!   ***" >> $onekey_deploy_log
#         exit 0
#    fi

}

######################################################################
# onekey deploy wxapi
wxapi(){
  echo "*** Begin onekey deploy wx api service! ***"
  /bin/bash $mvn_script -i 
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -w 
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -i && /bin/bash $deploy_script -w
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　  wxapi onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy wxapi succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　  wxapi onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy wxapi failed!   ***" >> $onekey_deploy_log
  # fi
}
######################################################################
# onekey deploy zjtapi
zjtapi(){
  echo "*** Begin onekey deploy zjt api service! ***"
    /bin/bash $mvn_script -i 
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -z  
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -i && /bin/bash $deploy_script -z
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　zjtapi onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy zjtapi succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　zjtapi onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy zjtapi failed!   ***" >> $onekey_deploy_log
  # fi
}
######################################################################
# onekey deploy njdxapi
njdxapi(){
  echo "*** Begin onekey deploy njdx api service! ***"
    /bin/bash $mvn_script -i 
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -j   
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -i && /bin/bash $deploy_script -j
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　njdxapi onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy njdxapi succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　njdxapi onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy njdxapi failed!   ***" >> $onekey_deploy_log
  # fi
}
######################################################################
# onekey deploy userapi
userapi(){
  echo "*** Begin onekey deploy user api service! ***"
    /bin/bash $mvn_script -i 
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -u 
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -i && /bin/bash $deploy_script -i
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　userapi onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy userapi succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　userapi onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy userapi failed!   ***" >> $onekey_deploy_log
  # fi
}
######################################################################
# onekey deploy aniuadmin
aniuadmin(){
  echo "*** Begin onekey deploy aniu admin service! ***"
  /bin/bash $mvn_script -I 
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -I
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -I && /bin/bash $deploy_script -I
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　aniuadmin onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy aniuadmin succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　aniuadmin onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy aniuadmin failed!   ***" >> $onekey_deploy_log
  # fi
}
######################################################################
# onekey deploy mmsadmin
mmsadmin(){
  echo "*** Begin onekey deploy mmsadmin service! ***"
    /bin/bash $mvn_script -M 
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -M
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -M && /bin/bash $deploy_script -M
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　mmsadmin onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy mmsadmin succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　mmsadmin onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy mmsadmin failed!   ***" >> $onekey_deploy_log
  # fi
}
######################################################################
# onekey deploy adminicntv
adminicntv(){
  echo "*** Begin onekey deploy icntv admin service! ***"
    /bin/bash $mvn_script -N
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -N
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -N && /bin/bash $deploy_script -N
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　adminicntv onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy adminicntv succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　adminicntv onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy adminicntv failed!   ***" >> $onekey_deploy_log
  # fi
}
######################################################################
# onekey deploy crmadmin
crmadmin(){
  echo "*** Begin onekey deploy crm admin service! ***"
      /bin/bash $mvn_script -C
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -C
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -C && /bin/bash $deploy_script -C
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　crmadmin onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy crmadmin succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　crmadmin onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy crmadmin failed!   ***" >> $onekey_deploy_log
  # fi
}
######################################################################
# onekey deploy crmapi
crmapi(){
  echo "*** Begin onekey deploy aniu api service! ***"
        /bin/bash $mvn_script -c 
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -c
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -c && /bin/bash $deploy_script -c
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　crmapi onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy crmapi succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　crmapi onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy crmapi failed!   ***" >> $onekey_deploy_log
  # fi
}
######################################################################
# onekey deploy aniuapi
nkmapi(){
  echo "*** Begin onekey deploy niukeme api service! ***"
        /bin/bash $mvn_script -k
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -k
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -k && /bin/bash $deploy_script -k
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　nkmapi onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy nkmapi succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　nkmapi onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy nkmapi failed!   ***" >> $onekey_deploy_log
  # fi
}
########################################################################
# onekey deploy nkmadmin
nkmadmin(){
  echo "*** Begin onekey deploy aniu admin service! ***"
        /bin/bash $mvn_script -K 
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -K
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi

  # /bin/bash $mvn_script -K && /bin/bash $deploy_script -K
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　nkmadmin onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy nkmadmin succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　nkmadmin onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy nkmadmin failed!   ***" >> $onekey_deploy_log
  # fi
}
#
########################################################################
# onekey deploy nkmtask
nkmtask(){
  echo "*** Begin onekey deploy nkm api task service! ***"
  /bin/bash $mvn_script -T
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -T
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -T && /bin/bash $deploy_script -T
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　nkmtask onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy nkmtask succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　nkmtask onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy nkmtask failed!   ***" >> $onekey_deploy_log
  # fi
}
########################################################################
# onekey deploy prodaductpi
productapi(){
  echo "*** Begin onekey deploy product api service! ***"

  /bin/bash $mvn_script -p
    if [ $? -ne 0 ];then
    echo ""
    /bin/bash $deploy_script -p
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed!" >> $onekey_deploy_log
    exit 0
  fi

#  /bin/bash $mvn_script -p && /bin/bash $deploy_script -p
#  echo ""
#  if [ $? -eq 0 ];then
#      echo "*************************************************"
#      echo "***　　　prodaductpi onekey deploy succeed!       ***"
#      echo "*************************************************"
#      echo "***  $Date onekey deploy prodaductpi succeed!  ***" >> $onekey_deploy_log
#  else
#    echo "*************************************************"
#      echo "***　　　prodaductpi onekey deploy failed!        ***"
#      echo "*************************************************"
#      echo "***  $Date onekey deploy prodaductpi failed!   ***" >> $onekey_deploy_log
#  fi
}
########################################################################
# onekey deploy productservice && aniuapy
productservice(){
  echo "*** Begin onekey deploy aniu product service! ***"
        /bin/bash $mvn_script -P 
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -P
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -P && /bin/bash $deploy_script -P
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　productservice onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy productservice succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　productservice onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy productservice failed!   ***" >> $onekey_deploy_log
  # fi
}
########################################################################
# onekey deploy messagechannel
messagechannel(){
  echo "*** Begin onekey deploy message channel service! ***"
        /bin/bash $mvn_script -m 
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -m
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -m && /bin/bash $deploy_script -m
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　messagechannel onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy messagechannel succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　messagechannel onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy messagechannel failed!   ***" >> $onekey_deploy_log
  # fi
}
########################################################################
# onekey deploy stockapi
stockapi(){
  echo "*** Begin onekey deploy stock api service! ***"
        /bin/bash $mvn_script -s 
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -s
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -s && /bin/bash $deploy_script -s
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　stockapi onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy stockapi succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　stockapi onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy stockapi failed!   ***" >> $onekey_deploy_log
  # fi
}
########################################################################
# onekey deploy algoquoteadmin
algoquoteadmin(){
  echo "*** Begin onekey deploy algoquote admin service! ***"
  /bin/bash $mvn_script -G
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -G
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -G && /bin/bash $deploy_script -G
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　algoquoteadmin onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy algoquoteadmin succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　algoquoteadmin onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy algoquoteadmin failed!   ***" >> $onekey_deploy_log
  # fi
}
########################################################################
# onekey deploy vcmsapi
vcmsapi(){
  echo "*** Begin onekey deploy vcms api service! ***"
  /bin/bash $mvn_script -v
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -v
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -v && /bin/bash $deploy_script -v
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　vcmsapi onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy vcmsapi succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　vcmsapi onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy vcmsapi failed!   ***" >> $onekey_deploy_log
  # fi
}

########################################################################
# onekey deploy vcmsadmin
vcmsadmin(){
  echo "*** Begin onekey deploy vcms api service! ***"
  /bin/bash $mvn_script -V
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -V
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -V && /bin/bash $deploy_script -V
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　vcmsadmin onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy vcmsadmin succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　vcmsadmin onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy vcmsadmin failed!   ***" >> $onekey_deploy_log
  # fi
}
########################################################################
# onekey deploy vcmssynch
vcmssynch(){
  echo "*** Begin onekey deploy vcms admin service! ***"
  /bin/bash $mvn_script -Y
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -Y
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -Y && /bin/bash $deploy_script -Y
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　vcmssynch onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy vcmssynch succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　vcmssynch onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy vcmssynch failed!   ***" >> $onekey_deploy_log
  # fi
}
# onekey deploy vcmsapi
vcmsapi(){
  echo "*** Begin onekey deploy vcms synch service! ***"
  /bin/bash $mvn_script -G
  if [ $? -eq 0 ];then
    echo ""
    echo " $Date Localhost Mvn deploy succeed!"
    /bin/bash $deploy_script -G
    echo " $Date Localhost Mvn deploy succeed!" >> $onekey_deploy_log
    else 
    echo ""
    echo " $Date Localhost Mvn deploy failed! "
    echo " $Date Localhost Mvn deploy failed! " >> $onekey_deploy_log
    exit 0
  fi
  # /bin/bash $mvn_script -G && /bin/bash $deploy_script -G
  # echo ""
  # if [ $? -eq 0 ];then
  #     echo "*************************************************"
  #     echo "***　　　vcmsapi onekey deploy succeed!       ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy vcmsapi succeed!  ***" >> $onekey_deploy_log
  # else
  #     echo "*************************************************"
  #     echo "***　　　vcmsapi onekey deploy failed!        ***"
  #     echo "*************************************************"
  #     echo "***  $Date onekey deploy vcmsapi failed!   ***" >> $onekey_deploy_log
  # fi
}
################################################################################################
# Script common functions && Scripts Usage
#################################################################################################

help() {
  printf "Usage: %s: [-i] [-w] [-z] [-j] [-u] [-I] [-k] [-K] [-T] [-c] [-C] [-m] [-M] [-s] [-v] [-V] [-Y] [-p] [-P] [-A] [-N] [-G] args" $(basename $0)
  printf "\n
  -h -- display help (this page)
  -i -- onekey deploy aniu-api
  -w -- onekey deploy wx-api | order-api
  -z -- onekey deploy zjt-api
  -j -- onekey deploy njdx-api
  -u -- onekey deploy user-api
  -I -- onekey deploy aniu-admin
  -k -- onekey deploy niukeme api
  -T -- onekey deploy niukeme api task 
  -K -- onekey deploy niukeme admin
  -C -- onekey deploy aniu crm admin
  -c -- onekey deploy aniu crm api 
  -m -- onekey deploy aniu message api
  -s -- onekey deploy aniu stock api
  -v -- onekey deploy aniu vcms api
  -Y -- onekey deploy aniu vcms synch 
  -V -- onekey deploy aniu vcms admin
  -p -- onekey deploy aniu product api
  -P -- onekey deploy aniu product service
  -M -- onekey deploy aniu mmsadmin
  -N -- onekey deploy aniu admin icntv
  -G -- onekey deploy aniu algoquote admin \n\n"
}

# display version number
print_version() {
  printf "Version: %s\n" $version_num
}
# get options to play with and define the script behavior
get_options() {
  while getopts 'hiwzjuIkKTcCmMsvVYpPANG' OPTION;
  do
    case "$OPTION" in
      h)    help
                exit 0
                ;;
      version) print_version
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
      k)    nkmapi
                ;;
      T)    nkmtask
                ;;
      K)    nkmadmin
                ;;
      C)    crmadmin
                ;;
      c)    crmapi
                ;;
      m)    messagechannel
                ;;
      s)    stockapi
                ;;
      v)    vcmsapi
                ;;
      Y)    vcmssynch
                ;;
      V)    vcmsadmin
                ;;
      p)    productapi
                ;;
      P)    productservice
                ;;
      M)    mmsadmin
                ;;
      N)    adminicntv
                ;;
      G)    algoquoteadmin
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

# get options
get_options "$@"
