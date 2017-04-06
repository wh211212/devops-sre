#
wget http://archive.apache.org/dist/activemq/apache-activemq/5.9.0/apache-activemq-5.9.0-bin.tar.gz

#

ln -s /opt/apache-activemq-5.9.0/bin/activemq /etc/init.d/

#
/etc/init.d/activemq start

#
http://192.168.1.136:8161/ admin admin
