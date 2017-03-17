# 使用MySQL Yum存储库的快速指南


## 添加MySQL Yum源

- 下载：http://dev.mysql.com/downloads/repo/yum/.（本文已CentOS为例）

## 安装MySQL

```
sudo rpm -Uvh mysql57-community-release-el6-n.noarch.rpm
yum localinstall mysql57-community-release-el6-n.noarch.rpm -y # 安装
```

> 注：使用yum安装的mysql，会随着系统（yum update）更新而更新

## 版本选择

- 查看可供安装的MySQL版本

```
yum repolist all | grep mysql
```

## 配置MySQL源  
```
# 这些貌似不需要配置
# for mysql57-community
cat > /etc/yum.repos.d/mysql-community.repo < EOF
[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/6/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
EOF
```
---------
```
# for mysql56-community
cat > /etc/yum.repos.d/mysql-community.repo < EOF
[mysql57-community]
name=MySQL 5.6 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.6-community/el/6/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
EOF
```

###

yum repolist enabled | grep mysql

## install mysql

>  sudo yum install mysql-community-server -y

## start mysql

> sudo service mysqld start
> sudo service mysqld status  # 查看状态

- 仅对于MySQL 5.7：在服务器的初始启动时，出现以下情况，假定服务器的数据目录为空：

> 查看root密码：'root'@'localhost' 超级账户已被创建

sudo grep 'temporary password' /var/log/mysqld.log

- 修改MySQL密码

> ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';

- MySQL安全初始化（仅适用于MySQL 5.6）

>　mysql_secure_installation

## 安装其他MySQL的产品和零件

```
yum --disablerepo=\* --enablerepo='mysql*-community*' list available
sudo yum install package-name

```

## 使用MySQL Yum升级MySQL

- 1. 选择升级版本

> 重要
有关从MySQL 5.5升级到5.6，看到从MySQL 5.5升级到5.6的重要信息(https://dev.mysql.com/doc/refman/5.6/en/upgrading-from-previous-series.html)。
有关从MySQL 5.6升级到5.7的重要信息，请参阅从MySQL 5.6升级到5.7(https://dev.mysql.com/doc/refman/5.7/en/upgrading-from-previous-series.html)。
有关从MySQL 5.7升级到8.0的重要信息，请参阅从MySQL 5.7升级到8.0(https://dev.mysql.com/doc/refman/8.0/en/upgrading-from-previous-series.html)。

- 2. 升级

> sudo yum update mysql-server
