# CentOS6 安装使用Gitlab

- 1. 必要的安装和配置

If you install Postfix to send email please select 'Internet Site' during setup. Instead of using Postfix you can also use Sendmail or configure a custom SMTP server and configure it as an SMTP server.

```
sudo yum install curl openssh-server openssh-clients postfix cronie
sudo service postfix start
sudo chkconfig postfix on
sudo lokkit -s http -s ssh
```
- 2. 使用gitlab官网方案安装

```
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
sudo yum install gitlab-ce
#
curl -LJO https://packages.gitlab.com/gitlab/gitlab-ce/packages/el/6/gitlab-ce-XXX.rpm/download
rpm -i gitlab-ce-XXX.rpm
```

- 3. 配置并使用gitlab

>  注：如果需要使用域名访问，建议先修改配置文件
```
# 编辑gitlab.yml文件，把其中的host改为你想好访问的域名
/var/opt/gitlab/gitlab-rails/etc/gitlab.yml

然后配置/etc/hosts,添加下面两行
127.0.0.1 gitlab.aniu.so
192.168.0.55 gitlab.aniu.so
```
> 配置文件修改完成之后，启动gitlab
```
sudo gitlab-ctl reconfigure

```

> gitlab启动成功之后访问gitlab：http://gitlab.aniu.so ,初始密码如下：

```
Username: root Password: 5iveL!fe
```
![这里写图片描述](http://img.blog.csdn.net/20170515201829122?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

# root 忘记重置
```
[root@gitlab ~]# gitlab-rails console production
irb(main):014:0> user = User.where(id: 1).first
=> #<User id: 1, email: "admin@example.com", created_at: "2017-05-13 10:01:45", updated_at: "2017-05-15 12:02:08", name: "Administrator", admin: true, projects_limit: 100000, skype: "", linkedin: "", twitter: "", authentication_token: "sjgFSYrUUpSyefQew79k", bio: nil, username: "root", can_create_group: true, can_create_team: false, state: "active", color_scheme_id: 1, password_expires_at: nil, created_by_id: nil, last_credential_check_at: nil, avatar: nil, hide_no_ssh_key: false, website_url: "", notification_email: "admin@example.com", hide_no_password: false, password_automatically_set: false, location: nil, encrypted_otp_secret: nil, encrypted_otp_secret_iv: nil, encrypted_otp_secret_salt: nil, otp_required_for_login: false, otp_backup_codes: nil, public_email: "", dashboard: 0, project_view: 2, consumed_timestep: nil, layout: 0, hide_project_limit: false, otp_grace_period_started_at: nil, ldap_email: false, external: false, incoming_email_token: "bvffkbrr2uoek5v9hzoje6wc4", organization: nil, authorized_projects_populated: nil, ghost: nil, last_activity_on: nil, notified_of_own_activity: false, require_two_factor_authentication_from_group: false, two_factor_grace_period: 48>
irb(main):015:0> user.password=12345678
=> 12345678
irb(main):016:0> user.password_confirmation=12345678
=> 12345678
irb(main):017:0> user.save!
Enqueued ActionMailer::DeliveryJob (Job ID: ea6384f9-eeff-439e-ad21-00a9a4dd98ed) to Sidekiq(mailers) with arguments: "DeviseMailer", "password_change", "deliver_now", gid://gitlab/User/1
=> true
irb(main):018:0> quit
# 建议使用12345678，然后登录成功之后再通过web界面修改密码
```
