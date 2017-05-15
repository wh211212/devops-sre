1. Install and configure the necessary dependencies

If you install Postfix to send email please select 'Internet Site' during setup. Instead of using Postfix you can also use Sendmail or configure a custom SMTP server and configure it as an SMTP server.

On CentOS, the commands below will also open HTTP and SSH access in the system firewall.

sudo yum install curl openssh-server openssh-clients postfix cronie
sudo service postfix start
sudo chkconfig postfix on
sudo lokkit -s http -s ssh
2. Add the GitLab package server and install the package

curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
sudo yum install gitlab-ce
If you are not comfortable installing the repository through a piped script, you can find the entire script here and select and download the package manually and install using

curl -LJO https://packages.gitlab.com/gitlab/gitlab-ce/packages/el/6/gitlab-ce-XXX.rpm/download
rpm -i gitlab-ce-XXX.rpm
3. Configure and start GitLab

sudo gitlab-ctl reconfigure

# Username: root
Password: 5iveL!fe
