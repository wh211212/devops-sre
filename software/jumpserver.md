# CentOS7安装开源跳板机(堡垒机)

> 开源跳板机(堡垒机):认证,授权,审计,自动化运维(Open source springboard machine ( fortress machine ): Authentication, authorization, audit, automated operation and maintenance).http://www.jumpserver.org

- https://github.com/jumpserver/jumpserver

# jumpserver安装

- 安装依赖
```
yum -y install git python-pip gcc automake autoconf python-devel vim sshpass lrzsz
```
- 下载jumpserver

```
git clone https://github.com/jumpserver/jumpserver.git
```
> 注：不要安装在/root、/home 等目录下，以免权限问题

- 运行安装脚本

```
cd jumpserver/install/
./install.py
```

> 请输入管理员用户名 [admin]: admin
> 请输入管理员密码: [5Lov@wife]: 5Lov@wife
> 请再次输入管理员密码: [5Lov@wife]: 5Lov@wife
> Starting jumpserver service:                               [  OK  ]

> 安装成功，Web登录请访问http://ip:8000, 祝你使用愉快。
> 请访问 https://github.com/jumpserver/jumpserver/wiki 查看文档


> 默认用户：jumpserver 默认密码: 5Lov@wife

# 不使用本地数据需执行以下操作

GRANT ALL PRIVILEGES ON jumpserver.* TO 'jumpserver'@'192.168.%' IDENTIFIED BY '@Aniujumpserver123.';
flush privileges;

> 邮箱地址设置：
> smtp.163.com
> 25
> yunwei@*****
>

- http://192.168.1.159:8000/login/

> admin 5Lov@wife  #默认用户名密码

# jumpserver使用

>　https://github.com/jumpserver/jumpserver/wiki/%E5%BA%94%E7%94%A8%E5%9B%BE%E8%A7%A3
