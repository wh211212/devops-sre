# CentOS 7安装Samba

## Samba简介

> Samba是在Linux和UNIX系统上实现SMB协议的一个免费软件，由服务器及客户端程序构成。SMB（Server Messages Block，信息服务块）是一种在局域网上共享文件和打印机的一种通信协议，它为局域网内的不同计算机之间提供文件及打印机等资源的共享服务。SMB协议是客户机/服务器型协议，客户机通过该协议可以访问服务器上的共享文件系统、打印机及其他资源。通过设置“NetBIOS over TCP/IP”使得Samba不但能与局域网络主机分享资源，还能与全世界的电脑分享资源。

## 完全访问共享文件夹

> 安装Samba来配置文件服务器。 此示例显示创建一个完全访问的共享文件夹，任何人都可以读写，并且不需要身份验证。

- 配置samba

```
[root@linuxprobe ~]# yum -y install samba samba-client
[root@linuxprobe ~]# mkdir /home/share
[root@linuxprobe ~]# chmod 777 /home/share
[root@linuxprobe ~]# vi /etc/samba/smb.conf
# [global] 添加以下参数
unix charset = UTF-8
dos charset = CP932
workgroup = WORKGROUP
hosts allow = 127. 10.0.0.
yunwei = user
passdb backend = tdbsam
map to guest = Bad User

# 最后添加下面参数
[Share]
    path = /home/share  # shared directory
    writable = yes      # writable
    guest ok = yes      # guest allowed
    guest only = yes    # guest only
    create mode = 0777  # fully accessed file
    directory mode = 0777 # fully accessed directory
[root@linuxprobe ~]# systemctl start smb nmb
[root@linuxprobe ~]# systemctl enable smb nmb
```
- 添加防火墙规则，关闭情况下不需要

```
[root@linuxprobe ~]# firewall-cmd --add-service=samba --permanent
success
[root@linuxprobe ~]# firewall-cmd --reload
success
```

- 配置selinux规则，建议关闭selinux

```
[root@linuxprobe ~]# setsebool -P samba_enable_home_dirs on
[root@linuxprobe ~]# restorecon -R /home/share
```

- Win10上添加samba共享目录

> 打开计算机--> 网络位置右键添加选择（添加一个网络位置）-->指定网络位置输入samba服务器共享的目录，格式为（\\samba_ip\sahre）-->下一步，点击完成

## 有限访问共享文件夹

> 安装并配置需要用户认证的samba共享文件夹

- 配置samba

```
[root@linuxprobe ~]# yum -y install samba samba-client
[root@linuxprobe ~]# groupadd yunwei
[root@linuxprobe ~]# mkdir /home/yunwei
[root@linuxprobe ~]# chgrp yunwei /home/yunwei
[root@linuxprobe ~]# chmod 770 /home/yunwei
[root@linuxprobe ~]# vi /etc/samba/smb.conf
# [global] 添加以下参数
unix charset = UTF-8
workgroup = WORKGROUP
hosts allow = 127. 10.0.0.
# 最后添加参数如下：
[yunwei]
    path = /home/yunwei
    writable = yes
    create mode = 0770
    directory mode = 0770
    guest ok = no# guest not allowed
    valid users = @yunwei
[root@linuxprobe ~]# systemctl start smb nmb
[root@linuxprobe ~]# systemctl enable smb nmb
# add a user in Samba
[root@linuxprobe ~]# smbpasswd -a wh
New SMB password:     # set password
Retype new SMB password:     # confirm
Added user cent.
[root@linuxprobe ~]# usermod -G yunwei wh
```
samba 提示Failed to initialize the registry: WERR_CAN_NOT_COMPLETE 无法启动
[root@glusterfs-node-1 samba]# find / -name registry.tdb
/var/lib/samba/registry.tdb
[root@glusterfs-node-1 samba]# rm -rf /var/lib/samba/registry.tdb
