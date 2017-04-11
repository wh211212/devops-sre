
# set hostname
hostnamectl set-hostname linuxprobe

# Disable IPv6

```
[root@localhost ~]# vi /etc/default/grub
# line 6: add
GRUB_CMDLINE_LINUX="ipv6.disable=1 rd.lvm.lv=fedora-server/root.....
# apply changing
[root@localhost ~]# grub2-mkconfig -o /boot/grub2/grub.cfg
[root@localhost ~]# reboot
```

# change NIC em1 to eth0
[root@linuxprobe ~]# vi /etc/default/grub
# line 6: add
GRUB_CMDLINE_LINUX="net.ifnames=0 rd.lvm.lv=fedora/swap rd.md=0.....
# apply changing
[root@linuxprobe ~]# grub2-mkconfig -o /boot/grub2/grub.cfg
[root@linuxprobe ~]# reboot

# display the list of services which are running
[root@linuxprobe ~]# systemctl -t service

# add repos
[1]	Install a plugin to add priorities to each installed repositories.
[root@linuxprobe ~]# yum -y install yum-plugin-priorities
# set [priority=1] to official repository
[root@linuxprobe ~]# sed -i -e "s/\]$/\]\npriority=1/g" /etc/yum.repos.d/CentOS-Base.repo
[2]	Add EPEL Repository which is provided from Fedora project.
[root@linuxprobe ~]# yum -y install epel-release
# set [priority=5]
[root@linuxprobe ~]# sed -i -e "s/\]$/\]\npriority=5/g" /etc/yum.repos.d/epel.repo
# for another way, change to [enabled=0] and use it only when needed
[root@linuxprobe ~]# sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/epel.repo
# if [enabled=0], input a command to use the repository
[root@linuxprobe ~]# yum --enablerepo=epel install [Package]
[3]	Add CentOS SCLo Software collections Repository.
[root@linuxprobe ~]# yum -y install centos-release-scl-rh centos-release-scl
# set [priority=10]
[root@linuxprobe ~]# sed -i -e "s/\]$/\]\npriority=10/g" /etc/yum.repos.d/CentOS-SCLo-scl.repo
[root@linuxprobe ~]# sed -i -e "s/\]$/\]\npriority=10/g" /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo
# for another way, change to [enabled=0] and use it only when needed
[root@linuxprobe ~]# sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/CentOS-SCLo-scl.repo
[root@linuxprobe ~]# sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo
# if [enabled=0], input a command to use the repository
[root@linuxprobe ~]# yum --enablerepo=centos-sclo-rh install [Package]
[root@linuxprobe ~]# yum --enablerepo=centos-sclo-sclo install [Package]
[4]	Add Remi's RPM Repository which provides many useful packages.
[root@linuxprobe ~]# yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
# set [priority=10]
[root@linuxprobe ~]# sed -i -e "s/\]$/\]\npriority=10/g" /etc/yum.repos.d/remi-safe.repo
# for another way, change to [enabled=0] and use it only when needed
[root@linuxprobe ~]# sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/remi-safe.repo
# if [enabled=0], input a command to use the repository
[root@linuxprobe ~]# yum --enablerepo=remi-safe install [Package]
