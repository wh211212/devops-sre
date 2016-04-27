#!/bin/bash
#functions:deploy jdk tomcat env
#date:2016-04-22
#Make sure only root can run our script
#set -x
RETVAL=0

  if [[ $EUID -ne $RETVAL ]]; then
           echo "Error:This script must be run as root!" 1>&2
           exit $RETVAL
  fi

#we use version 1.7.0_79,lastest version 1.8.0_92
#wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jdk-8u92-linux-x64.rpm
#wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b14/jdk-7u79-linux-x64.rpm
#JAVA_OPTIONS
JAVA_VERSION=1.7.0_79
#RETVAL=0
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b14/jdk-7u79-linux-x64.rpm

if [ $RETVAL -eq 0 ];then
     echo "wget java succeed"
  else
     echo "wget java failed"
     exit $RETVAL
#
rpm -ivh jdk-7u79-linux-x64.rpm
#
cat > /etc/profile.d/jdk.sh << 'EOF'
#JDK options
export JAVA_HOME=/usr/java/jdk1.7.0_79
export JAVA_BIN=${JAVA_HOME}/bin
export PATH=${JAVA_BIN}:$PATH
export CLASS_PATH=.:${JAVA_HOME}/lib/tools.jar:${JAVA_HOME}/lib/dt.jar
EOF

chmod 755 /etc/profile.d/jdk.sh
bash /etc/profile.d/jdk.sh &>/dev/null
source /etc/profile &>/dev/null
#
java -version &>/dev/null
if [ $? -eq 0 ];then
       echo "jdk install succeed"
   else
       echo "jdk deploy failed"
fi
