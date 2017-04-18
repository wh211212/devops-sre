# CentOS 7 安装GitLab

> GitLab是一个利用Ruby on Rails开发的开源应用程序，实现一个自托管的Git项目仓库，可通过Web界面进行访问公开的或者私人项目.
> Gitlab中文网：https://www.gitlab.com.cn/
> Gitlab官网：https://about.gitlab.com/
> Gitlab官方文档：https://docs.gitlab.com/ce/README.html

- CentOS7配置SSH

> http://blog.csdn.net/wh211212/article/details/52932776

- CentOS7配置SMTP

>　http://blog.csdn.net/wh211212/article/details/53040620

## 安装Gitlab

> 参考链接：https://www.gitlab.com.cn/downloads/#centos7

- 安装配置依赖项

>　使用Postfix来发送邮件,在安装期间请选择'Internet Site'. 您也可以用sendmai或者 配置SMTP服务 并 使用SMTP发送邮件.在 Centos 6 和 7 系统上, 下面的命令将在系统防火墙里面开放HTTP和SSH端口.（参考上面链接和下面操作）

```
sudo yum install curl policycoreutils openssh-server openssh-clients
sudo systemctl enable sshd
sudo systemctl start sshd
sudo yum install postfix
sudo systemctl enable postfix
sudo systemctl start postfix
sudo firewall-cmd --permanent --add-service=http
sudo systemctl reload firewalld
```

- 添加GitLab仓库,并安装到服务器上

```
curl -sS http://packages.gitlab.cc/install/gitlab-ce/script.rpm.sh | sudo bash
sudo yum install gitlab-ce
# 手动下载rpm包安装
curl -LJO https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el7/gitlab-ce-XXX.rpm
rpm -i gitlab-ce-XXX.rpm
```

- 启动GitLab

```
sudo gitlab-ctl reconfigure
```

- 使用浏览器访问GitLab

> 首次访问GitLab,系统会让你重新设置管理员的密码,设置成功后会返回登录界面.默认的管理员账号是root,如果你想更改默认管理员账号,请输入上面设置的新密码登录系统后修改帐号名.
