# CentOS 7 配置Ruby语言开发环境（Ruby）

### 安装Ruby 2.2

> CentOS7存储库中的Ruby版本为2.0，但如果需要，可以使用RPM软件包安装2.2

- 添加CentOS SCLo软件集合存储库

```
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
# 安装ruby
yum --enablerepo=centos-sclo-rh -y install rh-ruby22
```

- 软件集合的软件包安装在/opt目录下， 要使用它，需要加载环境变量，如下所示:

```
#  加载环境变量
[root@linuxprobe ~]# scl enable rh-ruby22 bash
[root@linuxprobe ~]# ruby -v
ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-linux]
[root@linuxprobe ~]# which ruby
/opt/rh/rh-ruby22/root/usr/bin/ruby
```

- 设置登录时自动启用Ruby 2.2，按如下所示进行配置：

```
[root@linuxprobe ~]# vim /etc/profile.d/rh-ruby22.sh
#!/bin/bash
source /opt/rh/rh-ruby22/enable
export X_SCLS="`scl enable rh-ruby22 'echo $X_SCLS'`"
export PATH=$PATH:/opt/rh/rh-ruby22/root/usr/local/bin
```

### 安装Ruby 2.3

```
# 安装ruby
yum --enablerepo=centos-sclo-rh -y install rh-ruby23
```

- 软件集合的软件包安装在/opt目录下， 要使用它，需要加载环境变量，如下所示:

```
#  加载环境变量
[root@linuxprobe ~]# scl enable rh-ruby23 bash
[root@linuxprobe ~]# ruby -v
ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-linux]
[root@linuxprobe ~]# which ruby
/opt/rh/rh-ruby22/root/usr/bin/ruby
```

- 设置登录时自动启用Ruby 2.3，按如下所示进行配置：

```

[root@linuxprobe ~]# vim /etc/profile.d/rh-ruby23.sh
#!/bin/bash
source /opt/rh/rh-ruby23/enable
export X_SCLS="`scl enable rh-ruby23 'echo $X_SCLS'`"
export PATH=$PATH:/opt/rh/rh-ruby23/root/usr/local/bin
```

## 安装Ruby on Rails 4来构建Ruby Framework环境

- 添加EPEL软件存储库

```
[root@linuxprobe ~]# yum -y install epel-release
# set [priority=5]
[root@linuxprobe ~]# sed -i -e "s/\]$/\]\npriority=5/g" /etc/yum.repos.d/epel.repo
# for another way, change to [enabled=0] and use it only when needed
[root@linuxprobe ~]# sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/epel.repo
# if [enabled=0], input a command to use the repository
[root@linuxprobe ~]# yum --enablerepo=epel install [Package]
```
## Ruby on Rails 4

- 安装Ruby 2.2，参考上面
- 安装依赖包（epel+SCLo）

```
[root@linuxprobe ~]# yum --enablerepo=epel,centos-sclo-rh -y install rh-ruby22-ruby-devel nodejs libuv gcc make libxml2 libxml2-devel mariadb-devel zlib-devel libxslt-devel
```

- 安装Rails 4

```
[root@linuxprobe ~]# gem install bundler
[root@linuxprobe ~]# gem install nokogiri -- --use-system-libraries
[root@linuxprobe ~]# gem install rails --version="~>4.0" --no-ri --no-rdoc
[root@linuxprobe ~]# /opt/rh/rh-ruby22/root/usr/local/bin/rails -v
Rails 4.2.8
```

## Ruby on Rails 5

- 安装Ruby 2.3，参考上面
- 安装依赖包（epel+SCLo）

```
[root@linuxprobe ~]# yum --enablerepo=epel,centos-sclo-rh -y install rh-ruby23-ruby-devel nodejs libuv gcc make libxml2 libxml2-devel mariadb-devel zlib-devel libxslt-devel
```

- 安装Rails 5

```
[root@linuxprobe ~]# gem install bundler
[root@linuxprobe ~]# gem install nokogiri -- --use-system-libraries
[root@linuxprobe ~]# gem install rails --no-ri --no-rdoc
[root@linuxprobe ~]# rails -v
Rails 5.0.2
```
### 创建一个示例应用程序，并确保其正常工作

- 需要安装MariaDB服务

```
[root@linuxprobe ~]# yum -y install mariadb-server
[root@linuxprobe ~]# vi /etc/my.cnf
# add follows within [mysqld] section
[mysqld]
character-set-server=utf8
[root@linuxprobe ~]# systemctl start mariadb
[root@linuxprobe ~]# systemctl enable mariadb
ln -s '/usr/lib/systemd/system/mariadb.service' '/etc/systemd/system/multi-user.target.wants/mariadb.service'
```
- 初始化MariaDB

```
[root@linuxprobe ~]# mysql_secure_installation

NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user.  If you've just installed MariaDB, and
you haven't set the root password yet, the password will be blank,
so you should just press enter here.

Enter current password for root (enter for none):
OK, successfully used password, moving on...

Setting the root password ensures that nobody can log into the MariaDB
root user without the proper authorisation.

# set root password
Set root password? [Y/n] y
New password:
Re-enter new password:
Password updated successfully!
Reloading privilege tables..
 ... Success!

By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.
# remove anonymous users
Remove anonymous users? [Y/n] y
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

# disallow root login remotely
Disallow root login remotely? [Y/n] y
 ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

# remove test database
Remove test database and access to it? [Y/n] y
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

# reload privilege tables
Reload privilege tables now? [Y/n] y
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!

# connect to MariaDB with root
[root@linuxprobe ~]# mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 11
Server version: 5.5.52-MariaDB MariaDB Server

Copyright (c) 2000, 2016, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

# show user list
MariaDB [(none)]> select user,host,password from mysql.user;
+------+-----------+-------------------------------------------+
| user | host      | password                                  |
+------+-----------+-------------------------------------------+
| root | localhost | *E2ACEC2F2DA384EE6753673365DFEF35F0C272C9 |
| root | 127.0.0.1 | *E2ACEC2F2DA384EE6753673365DFEF35F0C272C9 |
| root | ::1       | *E2ACEC2F2DA384EE6753673365DFEF35F0C272C9 |
+------+-----------+-------------------------------------------+
3 rows in set (0.00 sec)

# show database list
MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
+--------------------+
3 rows in set (0.00 sec)

MariaDB [(none)]> exit
Bye
```

- 创建测试应用程序

```
[root@linuxprobe ~]# gem install mysql2 --no-ri --no-rdoc -- --with-mysql-config=/usr/bin/mysql_config
[root@linuxprobe ~]# rails new SampleApp -d mysql
[root@linuxprobe ~]# cd SampleApp
[root@linuxprobe SampleApp]# vi config/database.yml
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password: password   # MariaDB password
  socket: /var/lib/mysql/mysql.sock
# create test application
[root@dlp SampleApp]# rails db:create
Created database 'SampleApp_development'
Created database 'SampleApp_test'
[root@dlp SampleApp]# rails generate scaffold testapp name:string title:string body:text
[root@dlp SampleApp]# rails db:migrate
[root@dlp SampleApp]# rails server --binding=0.0.0.0
=> Booting Puma
=> Rails 5.0.2 application starting in development on http://0.0.0.0:3000
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.8.2 (ruby 2.3.1-p112), codename: Sassy Salamander
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop  
```

- 客户端访问http://10.1.1.53:3000/
