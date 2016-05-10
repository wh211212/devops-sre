#!/bin/sh
#funcitons: deploy tomcat service
#date: 2016-04-25
#auther: vdevops

RETVAL=0
  if [[ $EUID -ne $RETVAL ]]; then
           echo "Error:This script must be run as root!" 1>&2
           exit $RETVAL
  fi
#wget -P /usr/local/src url
#wget http://apache.opencas.org/tomcat/tomcat-7/v7.0.69/bin/apache-tomcat-7.0.69.tar.gz
#TOMCAT_OPTIONS
TOMCAT_VERSION=apache-tomcat-7.0.69
wget -P /usr/local/src wget http://apache.opencas.org/tomcat/tomcat-7/v7.0.69/bin/apache-tomcat-7.0.69.tar.gz

if [ $RETVAL -eq 0 ];then
     echo "wget tomcat succeed"
  else
     echo "wget tomcat failed"
     exit $RETVAL
fi
#
cd /usr/local/src
tar zxvf apache-tomcat-7.0.69.tar.gz -C /home/deploy/uncompression
#
if [ ! -d /data/tomcats ];then
     mkdir -p /data/tomcats
   else
     /data/tomcats is exist!
     exit $RETVAL
fi
mv $TOMCAT_VERSION /data/tomcats/tomcat
#
cat > /etc/profile.d/tomcat.sh << 'EOF'
export CATALINA_BASE=/data/tomcats/tomcat
export CATALINA_BIN=${CATALINA_BASE}/bin
export PATH=${CATALINA_BIN}:$PATH
EOF
chmod 755 /etc/profile.d/tomcat.sh
bash /etc/profile.d/tomcat.sh &>/dev/null

source /etc/profile &>/dev/null
bash ${CATALINA_BIN}startup.sh

#catalina.sh start &>/dev/null
netstat -nlptu | grep 8080 &>/dev/null
if [ $? -ne 0 ];then
           echo "tomcat install failed"
           exit 1
fi
