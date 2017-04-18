# CentOS 7安装ownCloud

> ownCloud官网：https://owncloud.org/
> ownCloud官方文档：https://doc.owncloud.org/

## 安装ownCloud

> 安装ownCloud 9，依赖于LNMP（环境）

- 安装Apache

> 参考：http://blog.csdn.net/wh211212/article/details/52982917

- 安装php

> 参考:http://blog.csdn.net/wh211212/article/details/52994505
> http://blog.csdn.net/wh211212/article/details/70208130

- 安装Mariadb

> 参考:http://blog.csdn.net/wh211212/article/details/53129488

- 安装ownCloud

```
# install from EPEL
[root@linuxprobe ~]# yum --enablerepo=epel -y install php-pear-MDB2-Driver-mysqli php-pear-Net-Curl
[root@linuxprobe ~]# wget http://download.owncloud.org/download/repositories/stable/CentOS_7/ce:stable.repo -P /etc/yum.repos.d
[root@linuxprobe ~]# yum -y install owncloud
[root@linuxprobe ~]# systemctl restart httpd
```

- 在MariaDB中为ownCloud添加用户和数据库。

```
[root@linuxprobe ~]# mysql -u root -p
Enter password:
ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)
[root@linuxprobe ~]# mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 11
Server version: 5.5.52-MariaDB MariaDB Server

Copyright (c) 2000, 2016, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> create database owncloud;
Query OK, 1 row affected (0.15 sec)

MariaDB [(none)]> grant all privileges on owncloud.* to owncloud@'localhost' identified by 'password';
Query OK, 0 rows affected (0.00 sec)

MariaDB [(none)]> flush privileges;
Query OK, 0 rows affected (0.00 sec)

MariaDB [(none)]> exit
Bye
```

> 注：如果系统开启selinux，需设置以下操作：

```
[root@linuxprobe ~]# semanage fcontext -a -t httpd_sys_rw_content_t /var/www/html/owncloud/apps
[root@linuxprobe ~]# semanage fcontext -a -t httpd_sys_rw_content_t /var/www/html/owncloud/config
[root@linuxprobe ~]# restorecon /var/www/html/owncloud/apps
[root@linuxprobe ~]# restorecon /var/www/html/owncloud/config
```

- 客户端访问URLhttp://10.1.1.53/owncloud：

![这里写图片描述](http://img.blog.csdn.net/20170418162220466?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

- 如果连接到数据库的信息是正确的，欢迎如下所示：

![这里写图片描述](http://img.blog.csdn.net/20170418162235754?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

- 这是ownCloud主页，可以使用ownCloud作为云存储。
![这里写图片描述](http://img.blog.csdn.net/20170418162319879?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
> https://doc.owncloud.org/server/9.1/user_manual/files/access_webdav.html
