# CentOS 7 配置php语言开发环境

> 初始化设置参考：http://blog.csdn.net/wh211212/article/details/52923673

## 安装PHP 5.6

> 可以从CentOS SCLo软件集进行安装。 即使安装了5.4，因为5.6位于另一个PATH上也是可以安装的。

```
# install from SCLo
[root@linuxprobe ~]# yum --enablerepo=centos-sclo-rh -y install rh-php56
```

- 加载环境变量

```
# load environment variables
[root@linuxprobe ~]# scl enable rh-php56 bash
[root@linuxprobe ~]# php -v
PHP 5.6.5 (cli) (built: Mar 23 2016 19:17:38)
Copyright (c) 1997-2014 The PHP Group
Zend Engine v2.6.0, Copyright (c) 1998-2014 Zend Technologies
[root@linuxprobe ~]# which php
/opt/rh/rh-php56/root/usr/bin/php
```

- 设置开机自启用环境变量

```
[root@linuxprobe ~]# vi /etc/profile.d/rh-php56.sh
#!/bin/bash
source /opt/rh/rh-php56/enable
export X_SCLS="`scl enable rh-php56 'echo $X_SCLS'`"
```

## 安装PHP 7.0

> 可以从Remi的存储库安装

```
[root@linuxprobe ~]# yum --enablerepo=remi-safe -y install php70
```

- 加载环境变量

```
[root@linuxprobe ~]# php70 -v
PHP 7.0.8 (cli) (built: Jun 22 2016 10:57:20) ( NTS )
Copyright (c) 1997-2016 The PHP Group
Zend Engine v3.0.0, Copyright (c) 1998-2016 Zend Technologies
[root@linuxprobe ~]# which php70
/bin/php70
[root@linuxprobe ~]# ll /bin/php70
lrwxrwxrwx 1 root root 32 Jul 6 09:58 /bin/php70 -> /opt/remi/php70/root/usr/bin/php
# load environment variables with SCL tool
[root@linuxprobe ~]# scl enable php70 bash
[root@linuxprobe ~]# php -v
PHP 7.0.8 (cli) (built: Jun 22 2016 10:57:20) ( NTS )
Copyright (c) 1997-2016 The PHP Group
Zend Engine v3.0.0, Copyright (c) 1998-2016 Zend Technologies
```

- 设置开机自启用环境变量

```
[root@linuxprobe ~]# vi /etc/profile.d/php70.sh
#!/bin/bash
source /opt/remi/php70/enable
export X_SCLS="`scl enable php70 'echo $X_SCLS'`"
```

## 安装PHP 7.1

> 可以从Remi的存储库安装

```
[root@linuxprobe ~]# yum --enablerepo=remi-safe -y install php71
```

- 加载环境变量

```
[root@linuxprobe ~]# php71 -v
PHP 7.1.3 (cli) (built: Mar 14 2017 16:22:48) ( NTS )
Copyright (c) 1997-2017 The PHP Group
Zend Engine v3.1.0, Copyright (c) 1998-2017 Zend Technologies
[root@linuxprobe ~]# which php71
/bin/php71
[root@linuxprobe ~]# ll /bin/php71
lrwxrwxrwx 1 root root 32 Jul 6 11:10 /bin/php71 -> /opt/remi/php71/root/usr/bin/php
# load environment variables with SCL tool
[root@linuxprobe ~]# scl enable php71 bash
[root@linuxprobe ~]# php -v
PHP 7.1.3 (cli) (built: Mar 14 2017 16:22:48) ( NTS )
Copyright (c) 1997-2017 The PHP Group
Zend Engine v3.1.0, Copyright (c) 1998-2017 Zend Technologies
```

- 设置开机自启用环境变量

```
[root@linuxprobe ~]# vi /etc/profile.d/php71.sh
#!/bin/bash
source /opt/remi/php71/enable
export X_SCLS="`scl enable php71 'echo $X_SCLS'`"
```

## 在Httpd上使用PHP7.1,配置php-fpm

- 安装php-fpm

```
# install Apache httpd
[root@linuxprobe ~]# yum install httpd -y
# install from Remi
[root@linuxprobe ~]# yum --enablerepo=remi-safe -y install php71-php-fpm
[root@linuxprobe ~]# vi /etc/httpd/conf.d/php.conf
# line 5: change like follows
<FilesMatch \.php$>
#    SetHandler application/x-httpd-php
    SetHandler "proxy:fcgi://127.0.0.1:9000"
</FilesMatch>
[root@linuxprobe ~]# systemctl start php71-php-fpm
[root@linuxprobe ~]# systemctl enable php71-php-fpm
[root@linuxprobe ~]# systemctl restart httpd
```
- 使用嵌入式方式

```
# install from Remi
[root@linuxprobe ~]# yum --enablerepo=remi-safe -y install php71-php
# rename and disable the old version if it exists
[root@linuxprobe ~]# mv /etc/httpd/conf.modules.d/15-php71-php.conf /etc/httpd/conf.modules.d/15-php71-php.conf.org
[root@linuxprobe ~]# systemctl restart httpd
# create phpinfo to verify working
[root@linuxprobe ~]# echo '<?php phpinfo(); ?>' > /var/www/html/info.php
[root@linuxprobe ~]# curl http://localhost/info.php | grep 'PHP Version' | tail -1 | sed -e 's/<[^>]*>//g'
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                               Dload  Upload   Total   Spent    Left  Speed
100    20  100    20    0     0   1601      0 --:--:-- --:--:-- --:--:--  1666
```
