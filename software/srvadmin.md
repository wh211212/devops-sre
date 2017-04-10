# 安装dell的yum源

wget -O - http://linux.dell.com/repo/hardware/latest/bootstrap.cgi | bash

## 安装OMSA

yum -y install OpenIPMI # 安装依赖包

yum install srvadmin-all -y

## 软链接
ln -s /opt/dell/srvadmin/sbin/omreport /usr/bin/omreport
ln -s /opt/dell/srvadmin/sbin/omconfig /usr/bin/omconfig

## 启动omsa

/etc/init.d/dataeng start

## 加入到开机启动

chkconfig dataeng on

## 清理yum源文件

rm -rf /etc/yum.repos.d/dell-*

# dell硬件监控工具OMSA常用命令

#命令可以查看当前系统中安装的软件和硬件组件的综合摘要。
omreport system summary
#CMOS电池状态
omreport chassis batteries
#风扇状态
omreport chassis fans
#内存状态
omreport chassis memory
#网卡状态
omreport chassis nics
#CPU状态
omreport chassis processors
#温度状态
omreport chassis temps
#硬盘状态
omreport storage pdisk controller=0
#电源状态
omreport chassis pwrsupplies
#raid 状态
omreport storage vdisk controller=0
