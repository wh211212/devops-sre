# 配置jenkins源

```
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
```

# yum安装jenkins

```
yum install jenkins
```

> Jenkins官方源：http://pkg.jenkins-ci.org/redhat/

# 启动jenkins

```
/etc/init.d/jenkins start
chkconfig jenkins on
```

# 客户端访问Jenkins

```
# http://192.168.0.103:8080/
# 查看默认密码
cat /var/lib/jenkins/secrets/initialAdminPassword
```

![这里写图片描述](http://img.blog.csdn.net/20170425154131574?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

- 选择建议安装的插件，继续如下：

![这里写图片描述](http://img.blog.csdn.net/20170425154158965?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

- 插件自动安装完成如下图：

![这里写图片描述](http://img.blog.csdn.net/20170425154452562?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

- 新建管理员账号，如果不主动创建默认使用admin

![这里写图片描述](http://img.blog.csdn.net/20170425154544954?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

- 使用admin账号登录jenkins如上图所示，后续博文介绍jenkins的具体使用细节
