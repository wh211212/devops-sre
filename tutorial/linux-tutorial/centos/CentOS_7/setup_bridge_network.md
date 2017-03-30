# CentOS7 桥接网络

vim /etc/sysconfig/network-scripts/ifcfg-br0

DEVICE="br0"
BOOTPROTO="static"
IPADDR="192.168.1.124"
NETMASK="255.255.255.0"
GATEWAY="192.168.1.1"
DNS1=114.114.114.114
ONBOOT="yes"
TYPE="Bridge"
NM_CONTROLLED="no"
DELAY=0

vi /etc/sysconfig/network-scripts/ifcfg-em1

DEVICE=em1
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED=no
BRIDGE=br0
HWADDR=d4:ae:52:86:cb:8b


systemctl restart network
