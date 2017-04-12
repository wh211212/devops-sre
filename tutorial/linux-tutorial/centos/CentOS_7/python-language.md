# CentOS 7 配置Python语言开发环境

> 初始化设置参考：http://blog.csdn.net/wh211212/article/details/52923673

## 安装Python 3.3

- whOS7默认自带python2.7，无需卸载可直接新装Python3.3

```
# install from SCLo
[root@linuxprobe ~]# yum --enablerepo=whos-sclo-rh -y install python33
```

- 设置环境变量

```
# load environment variables
[root@linuxprobe ~]# scl enable python33 bash
[root@linuxprobe ~]# python -V
Python 3.3.2
[root@linuxprobe ~]# which python
/opt/rh/python33/root/usr/bin/python

# 设置开机自启用环境变量设置
[root@linuxprobe ~]# vi /etc/profile.d/python33.sh
#!/bin/bash
source /opt/rh/python33/enable
export X_SCLS="`scl enable python33 'echo $X_SCLS'`"`

```
## 安装Python 3.3

- whOS7默认自带python2.7，无需卸载可直接新装Python3.3

```
# install from SCLo
[root@linuxprobe ~]# yum --enablerepo=whos-sclo-rh -y install python34
```

- 设置环境变量

```
# load environment variables
[root@linuxprobe ~]# scl enable python34 bash
[root@linuxprobe ~]# python -V
Python 3.4.2
[root@linuxprobe ~]# which python
/opt/rh/python34/root/usr/bin/python

# 设置开机自启用环境变量设置
[root@linuxprobe ~]# vi /etc/profile.d/python34.sh
#!/bin/bash
source /opt/rh/python34/enable
export X_SCLS="`scl enable python33 'echo $X_SCLS'`"`

```
## 安装Python 3.5

- whOS7默认自带python2.7，无需卸载可直接新装Python3.5

```
# install from SCLo
[root@linuxprobe ~]# yum --enablerepo=whos-sclo-rh -y install python35
```

- 设置环境变量

```
# load environment variables
[root@linuxprobe ~]# scl enable python35 bash
[root@linuxprobe ~]# python -V
Python 3.5.2
[root@linuxprobe ~]# which python
/opt/rh/python35/root/usr/bin/python

# 设置开机自启用环境变量设置
[root@linuxprobe ~]# vi /etc/profile.d/python35.sh
#!/bin/bash
source /opt/rh/python35/enable
export X_SCLS="`scl enable python33 'echo $X_SCLS'`"`

```

## 安装Django

- 安装依赖包

```
# install from EPEL
[root@linuxprobe ~]# yum --enablerepo=epel -y install python-virtualenv
```

- 使用普通用户wh在Virtualenv环境下安装Django

```
[wh@linuxprobe ~]$ virtualenv venv
New python executable in venv/bin/python
Installing Setuptools..............................................................................................................................................................................................................................done.
Installing Pip.....................................................................................................................................................................................................................................................................................................................................done.
[wh@linuxprobe ~]$ cd ~/venv
[wh@linuxprobe venv]$ source bin/activate
(venv)[wh@linuxprobe venv]$ pip install django
Downloading/unpacking django
  Downloading Django-1.11.tar.gz (7.9MB): 7.9MB downloaded
  Running setup.py egg_info for package django

    no previously-included directories found matching 'django/contrib/admin/bin'
    warning: no previously-included files matching '__pycache__' found anywhere in distribution
Downloading/unpacking pytz (from django)
  Downloading pytz-2017.2.zip (502kB): 502kB downloaded
  Running setup.py egg_info for package pytz

Installing collected packages: django, pytz
  Running setup.py install for django

    no previously-included directories found matching 'django/contrib/admin/bin'
    warning: no previously-included files matching '__pycache__' found anywhere in distribution
    changing mode of build/scripts-2.7/django-admin.py from 664 to 775
    changing mode of /home/wh/venv/bin/django-admin.py to 775
    Installing django-admin script to /home/wh/venv/bin
  Running setup.py install for pytz

Successfully installed django pytz
Cleaning up...
# the warning above is not a problem
(venv)[wh@linuxprobe venv]$ django-admin --version
1.11
(venv)[wh@linuxprobe venv]$ deactivate
[wh@linuxprobe venv]$
```
- 创建测试项目

```
[wh@linuxprobe venv]$ cd ~/venv
[wh@linuxprobe venv]$ source bin/activate
(venv)[wh@linuxprobe venv]$ django-admin startproject testproject
(venv)[wh@linuxprobe venv]$ cd testproject
(venv)[wh@linuxprobe testproject]$ python manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying sessions.0001_initial... OK
(venv)[wh@linuxprobe testproject]$  python manage.py createsuperuser
Username (leave blank to use 'wh'): wh
Email address: shaonbean@qq.com
Password:
Password (again):
This password is too short. It must contain at least 8 characters.  # 密码设置符合要求
This password is entirely numeric.
Password:
Password (again):
Superuser created successfully.
# 这里需要修改到创建的项目中去修改 setting.py 文件
---
> 改为： ALLOWED_HOSTS = ['*']
---
(venv)[wh@linuxprobe testproject]$ python manage.py runserver 10.1.1.53:8888
Performing system checks...

System check identified no issues (0 silenced).
April 12, 2017 - 14:20:32
Django version 1.11, using settings 'testproject.settings'
Starting development server at http://10.1.1.53:8888/
Quit the server with CONTROL-C.

```
- 客户端访问http://10.1.1.53:8888/

![这里写图片描述](http://img.blog.csdn.net/20170412202305987?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
- 客户端登录管理界面http://10.1.1.53:8888/admin
![这里写图片描述](http://img.blog.csdn.net/20170412202254627?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
![这里写图片描述](http://img.blog.csdn.net/20170412202230360?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
