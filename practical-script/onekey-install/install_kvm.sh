#!/bin/bash
#####################################################
# Functions: centos_6 mininal install kvm
# Auther: hwang@aniu.tv
#
#####################################################
# define variables
anynowtime="date +'%Y-%m-%d %H:%M:%S'"
NOW="echo [\`$anynowtime\`][PID:$$]"
#
# 1. 更新系统并安装依赖包

function os_upgrade
{
	yum update -y && yum -y install qemu-kvm libvirt python-virtinst bridge-utils
	echo "`eval $NOW` job_success"
    exit 0
}


# 2. 确认服务器已加载支持虚拟化的模块

function lsmod_modules
{
	# 
	lsmod | grep kvm
	if [ $? -eq 0 ];then
	    echo "`eval $NOW` lsmod_modules success"
	    exit 0
	    /etc/rc.d/init.d/libvirtd start && /etc/rc.d/init.d/messagebus start 
	    chkconfig libvirtd on &&  chkconfig messagebus on 
	  else
	    echo "`eval $NOW` lsmod_modules failed"
	    exit 1
	fi    
}

# 3. 为KVM虚拟机配置桥接网络,重启网络测试连通性

function config_network
{
	mv /etc/sysconfig/network-scripts/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-br0
	# cat >  /etc/sysconfig/network-scripts/ifcfg-br0 << EOF
	# # change
 #    DEVICE=br0
 #    HWADDR=00:0C:29:5F:03:42                               # server MAC
 #    # change
 #    TYPE=Bridge
 #    UUID=c1539085-73d7-4455-ac82-88f26464458a              # server UUID
 #    ONBOOT=yes
 #    NM_CONTROLLED=yes
 #    BOOTPROTO=none
 #    IPADDR=10.0.0.30                                       # server current ip
 #    NETMASK=255.255.255.0
 #    GATEWAY=10.0.0.1                                       # gateway
	# IPV6INIT=no
	# USERCTL=no
	# EOF

echo '# change
    DEVICE=br0
    HWADDR=40:8D:5C:68:17:50                               # server MAC
    # change
    TYPE=Bridge
    UUID=db594603-9691-4f64-b105-0084a9e43274              # server UUID
    ONBOOT=yes
    NM_CONTROLLED=yes
    BOOTPROTO=none
    IPADDR=10.1.1.59                                       # server current ip
    NETMASK=255.255.255.0
    GATEWAY=10.1.1.1                                      # gateway
    DNS2=114.114.114.114
    DNS1=10.1.1.1
	IPV6INIT=no
	USERCTL=no
' | sudo tee /etc/sysconfig/network-scripts/ifcfg-br0	
#
echo '
# create new
DEVICE=p4p1
TYPE=Ethernet
ONBOOT=yes
BRIDGE=br0
' | sudo tee vi /etc/sysconfig/network-scripts/ifcfg-p4p1


# restart network
/etc/rc.d/init.d/network restart 
ping www.baidu.com  

# 注、自定义个别配置
}












 
