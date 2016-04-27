#!/bin/bash
# funtion: initialization centos 
# author: wh
# date: 2016-3-11
# $myhostname=anonymous
#check the OS  
cat << EOF
+---------------------------------------------------------------------------+
|           Initialization for the CentOS 6_installed.                      |
+---------------------------------------------------------------------------+
EOF
 
function format() {
      #sleep 1
      echo -e "\033[32m Install Success!!!\033[0m\n"
                  }
 
##########################################################################
# Set time 时区/时间同步设置
echo "Set time."
/bin/cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &> /dev/null
yum -y install ntpdate &> /dev/null
ntpdate  0.centos.pool.ntp.org &> /dev/null
hwclock -w
format
 
##########################################################################
# Create Log 创建该脚本运行记录日志
echo "Create log file."
DATE=`date +"%F %H:%M"`
LOG=/var/log/sysinitinfo.log
echo $DATE >> $LOG
echo "------------------------------------------" >> $LOG
format
 
###########################################################################
# Disabled Selinux 禁用Selinux
echo "Disabled SELinux."
sed -i 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
format
 
###########################################################################
# Stop iptables 禁用iptables
echo "Stop iptables."
service iptables stop &> /dev/null
service ip6tables stop &> /dev/null
chkconfig --level 235 iptables off
format
 
###########################################################################
# Disable ipv6 禁用IPV6
echo "Disable ipv6."
cat << EOF > /etc/modprobe.conf
alias net-pf-10 off
alias ipv6 off
EOF
chkconfig --level 2235 ip6tables off
format
 
##########################################################################
#Set history commands  设置命令历史记录参数
echo "Set history commands."
sed -i 's/HISTSIZE=1000/HISTSIZE=100/' /etc/profile
sed -i "8 s/^/alias vi='vim'/" /root/.bashrc
sed -i "9 s/^/alias grep='grep --color" /etc/.bashrc
grep 'HISTFILESIZE' /etc/bashrc &>/dev/null
if [ $? -ne 0 ]
then
cat << EOF >> /etc/bashrc
HISTFILESIZE=4000
HISTSIZE=4000
HISTTIMEFORMAT='%F/%T'
EOF
fi
source /etc/bashrc
format
 
##########################################################################
# set vim
echo "Set Vim."
 
cat << EOF > ~/.vimrc
set number
set laststatus=2
set shiftwidth=4
set tabstop=4
set noexpandtab
set softtabstop=4
set cmdheight=3
set cursorline
set formatoptions=tcrqn 
set encoding=utf-8
 
syntax on
set bg=dark
colorscheme desert
color ron
set ruler 
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)
 
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
nmap z :x<cr>
nmap sp :set paste<cr>i
EOF
 
format
 
##########################################################################
# Epel 升级epel源
echo "Install epel"
rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm &> /dev/null
sed -i "s/^#base/base/g" /etc/yum.repos.d/epel.repo
sed -i "s/^mirr/#mirr/g" /etc/yum.repos.d/epel.repo
format
 
##########################################################################
#Yum install Development tools  安装开发包组及必备软件
#echo "Install Development tools(It will be a moment)"
#yum groupinstall -y "Development tools" &> /dev/null
#yum install -y bind-utils lrzsz wget gcc gcc-c++ vim htop openssl &>/dev/null
#format
 
##########################################################################
# Yum update bash and openssl  升级bash/openssl
#echo "Update bash and openssl"
#yum -y update bash openssl &> /dev/null
#format
 
###########################################################################
# Set ssh 设置ssh登录策略
echo "Set sshd."
sed -i "s/^#PermitEmptyPasswords/PermitEmptyPasswords/" /etc/ssh/sshd_config
sed -i "s/^#LoginGraceTime 2m/LoginGraceTime 6m/" /etc/ssh/sshd_config
 
grep "UseDNS no" /etc/ssh/sshd_config &>/dev/null
if [ $? -ne 0 ]
then
    echo "UseDNS no" >> /etc/ssh/sshd_config
fi
format
 
###########################################################################
# Set default init 3  设置系统默认初始化
echo "Default init 3."
sed -i 's/^id:5:initdefault:/id:3:initdefault:/' /etc/inittab
format
 
###########################################################################
echo "Tunoff services."
 
for i in `ls /etc/rc3.d/S*`
do
    servers=`echo $i|cut -c 15-`
 
    echo $servers
    case $servers in crond | irqbalance | microcode_ctl | network | random | postfix | sshd | rsyslog | local | smart | cpuspeed | mysqld | httpd | ntpd | php-fpm | nginx)
        echo -e "\033[31m Base services, Skip!\033[0m"
      ;;
      *)
        echo -e "\033[31m change $servers to off\033[0m"
        chkconfig --level 235 $servers off
        service $servers stop
      ;;
esac
done
 
format
 
###########################################################################
# Del unnecessary users 删除不必要的用户
echo "Del unnecessary users."
for USERS in adm lp sync shutdown halt mail news uucp operator games gopher
do
    grep $USERS /etc/passwd &>/dev/null
    if [ $? -eq 0 ]
    then
        userdel $USERS &> /dev/null
    fi
done
format
 
###########################################################################
# Del unnecessary groups 删除不必要的用户组
echo "Del unnecessary groups."
for GRP in adm lp mail news uucp games gopher mailnull floppy dip pppusers popusers slipusers daemon
do
    grep $GRP /etc/group &> /dev/null
    if [ $? -eq 0 ]
    then
        groupdel $GRP &> /dev/null
    fi
done
format
 
###########################################################################
# Disabled reboot by keys ctlaltdelete 禁用ctlaltdelete重启功能
echo "Disabled reboot by keys ctlaltdelete"
sed -i 's/^exec/#exec/' /etc/init/control-alt-delete.conf
format
 
###########################################################################
# Set ulimit  设置文件句柄数
echo "Set ulimit 1000000"
 
cat << EOF > /etc/security/limits.conf
*    soft    nofile  1000000
*    hard    nofile  1000000
*    soft    nproc 102400
*    hard    nproc 102400
EOF
sed -i 's/102400/1000000/' /etc/security/limits.d/90-nproc.conf
format
 
###########################################################################
# Set login message 设置登录时显示的信息
echo "Set login message."
echo "This is not a public Server" > /etc/issue
echo "This is not a public Server" > /etc/redhat-release
format
 
###########################################################################
# Record SUID and SGID files
DATE2=`date +"%F"`
echo "Record SUID and SGID files."
echo "SUID --- " > /var/log/SuSg_"$DATE2".log
find / -path '/proc'  -prune -o -perm -4000 >> /var/log/SuSg_"$DATE2".log
echo "------------------------------------------------------ " >> /var/log/SuSg_"$DATE2".log
echo "SGID --- " >> /var/log/SuSg_"$DATE2".log
find / -path '/proc'  -prune -o -perm -2000 >> /var/log/SuSg_"$DATE2".log
format
 
###########################################################################
# Disabled crontab send mail 禁用执行任务计划时向root发送邮件
echo "Disable crontab send mail."
sed -i 's/^MAILTO=root/MAILTO=""/' /etc/crontab
sed -i 's/^mail\.\*/mail\.err/' /etc/rsyslog.conf
format
 
###########################################################################
# Set ntp client 设置时间服务客户端
echo "Set ntp client."
SED() {
    cp -p /etc/ntp.conf /etc/ntp.conf.bak
    sed -i '/^server/d' /etc/ntp.conf
    sed -i '/^includefile/ i\server 0.centos.pool.ntp.org iburst' /etc/ntp.conf
    sed -i '/0.centos.pool.ntp.org/ a\server 1.centos.pool.ntp.org iburst' /etc/ntp.conf
    sed -i '/1.centos.pool.ntp.org/ a\server 2.centos.pool.ntp.org iburst' /etc/ntp.conf
    sed -i '/2.centos.pool.ntp.org/ a\server 3.centos.pool.ntp.org iburst' /etc/ntp.conf
    chkconfig --level 35 ntpd on &> /dev/null
}
rpm -q ntp &> /dev/null
if [ $? -eq 0 ]
then
    SED
else
    yum -y install ntp &> /dev/null
    SED
fi
format
 
###########################################################################
# Set sysctl.conf 设置内核参数
echo "Set sysctl.conf"
#web应用中listen函数的backlog默认会将内核参数的net.core.somaxconn限制到128，而nginx定义的NGX_LISTEN_BACKLOG默认是511，所以必须调整,一般调整为2048
cat << EOF > /etc/sysctl.conf
net.core.somaxconn = 2048
net.core.wmem_default = 262144
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 4096 16777216
net.ipv4.tcp_wmem = 4096 4096 16777216
net.ipv4.tcp_mem = 786432 2097152 3145728
net.ipv4.tcp_max_syn_backlog = 16384
net.core.netdev_max_backlog = 20000
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_max_orphans = 131072
net.ipv4.ip_local_port_range = 1024 65535
net.ipv4.ip_forward = 0
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 4294967295
kernel.shmall = 26843545
EOF
 
#modprobe bridge  > /dev/null
/sbin/sysctl  -p  > /dev/null
format
