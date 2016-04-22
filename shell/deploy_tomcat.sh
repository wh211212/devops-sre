#!/bin/sh
#
####################################################################
# Before the shell,you need to run this:                           #
#                                                                  #
# >cd /usr/local/workspace                                         #
# >git clone -b dev git@idcwxtest.dafysz.cn:root/mobile-biz.git    #
#                                                                  #
####################################################################

echo "======== Are you Ready?  =========="

_PRO_NAME=mobile-biz

_TOMCATS_NAME=(
tomcat-7.0.59-node1
tomcat-7.0.59-node6
)

_WAR_NAME=${_PRO_NAME}.war

_MAVEN_REPO_WAR=/usr/local/workspace/${_PRO_NAME}/${_PRO_NAME}/target/${_WAR_NAME}

_WAR_HIS=/usr/local/war/${_WAR_NAME}

_DATE=$(date +"%Y%m%d")    # 20150802
_TIME=$(date +"%H%M%S")    # 095501

cd /usr/local/workspace/mobile-biz/mobile-biz

echo "======== 1. <pull> from Git  =========="
git pull git@idcwxtest.dafysz.cn:root/mobile-biz.git dev
sleep 1

echo "======== 2. <clean install> By Maven  =========="
mvn clean install

echo "======== 3. loop all tomcat server  =========="

_index=0
for _tomcat_name in ${_TOMCATS_NAME[@]}
do 
  _TOMCAT_HOME=/usr/local/tomcat/${_tomcat_name}
  _TOMCAT_WEBAPPS_PRO=${_TOMCAT_HOME}/webapps/${_PRO_NAME}
  _TOMCAT_WEBAPPS_WAR=${_TOMCAT_HOME}/webapps/${_WAR_NAME}
  _TOMCAT_START=${_TOMCAT_HOME}/bin/startup.sh
  _TOMCAT_PID=$( ps aux | grep ${_tomcat_name} | grep -v grep | awk '{print $2}' )
  
  let _index+=1
  
  echo "ready for kill tomcat[${_index}]: ${_tomcat_name}"
  echo "Get ${_tomcat_name}'s PID: $_TOMCAT_PID"

  if [[ ${_TOMCAT_PID} ]]   # if PID exists 
  then
    echo "PID exists"
    echo "Kill ing... "
    kill -9 ${_TOMCAT_PID}
    sleep 3
	echo "KILLED, SUCC"
  else 
    echo "PID is not exists, ready for start."
  fi

  echo "======== <backup war> move war file to History/  =========="
  mv -f ${_TOMCAT_WEBAPPS_WAR} ${_WAR_HIS}.${_DATE}.${_TIME}
  echo "moved the war: [ ${_TOMCAT_WEBAPPS_WAR} ] to HIS, named: [ ${_WAR_HIS}.${_DATE}.${_TIME} ]"

  echo "======== <deploy new-war> add *.war to /webapps  =========="
  cp ${_MAVEN_REPO_WAR} ${_TOMCAT_WEBAPPS_WAR}
  echo "copy the file: [ ${_MAVEN_REPO_WAR} ] to tomcat home: [ ${_TOMCAT_WEBAPPS_WAR} ]"
  rm -rf ${_TOMCAT_WEBAPPS_PRO}

  echo "======== <starting tomcat> startup.sh  =========="
  ${_TOMCAT_START}
  sleep 3

done

echo -e "\n\nBuild Complete."
echo "  ^_^  "
echo ""
