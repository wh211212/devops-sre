# CentOS7+Apache(Nginx)+PHP+MySQL(Maridb)

- 系统初始化

> 初始化设置参考：http://blog.csdn.net/wh211212/article/details/52923673

- 安装Apache

> http://blog.csdn.net/wh211212/article/details/52982917

- 安装Nginx

> http://blog.csdn.net/wh211212/article/details/53018112

- 安装PHP

> http://blog.csdn.net/wh211212/article/details/70208130

- LNMP一键安装

> https://lnmp.org/

## 添加repo源

```
# plugin
yum -y install yum-plugin-priorities
sed -i -e "s/\]$/\]\npriority=1/g" /etc/yum.repos.d/CentOS-Base.repo
# epel
yum -y install epel-release
sed -i -e "s/\]$/\]\npriority=5/g" /etc/yum.repos.d/epel.repo
sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/epel.repo
# CentOS SCLo
yum -y install centos-release-scl-rh centos-release-scl
sed -i -e "s/\]$/\]\npriority=10/g" /etc/yum.repos.d/CentOS-SCLo-scl.repo
sed -i -e "s/\]$/\]\npriority=10/g" /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo
sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/CentOS-SCLo-scl.repo
sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo
# remi
yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sed -i -e "s/\]$/\]\npriority=10/g" /etc/yum.repos.d/remi-safe.repo
sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/remi-safe.repo
```

## yum安装httpd+php+maraidb

```
yum -y install httpd
systemctl start httpd
systemctl enable httpd

```
