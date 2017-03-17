#!/bin/bash
#################################################
#  --Info
#         Initialization CentOS 6.x script
#################################################
#  Changelog
#   20160601       shaonbean           initial creation
#################################################
#   Auther: hwang@aniu.tv
#   Changelog:
#   20170222   shaom   upgrade script
#################################################
# Check if user is root
#
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to initialization OS"
    exit 1
fi

echo "+------------------------------------------------------------------------+"
echo "|       To initialization the system for security and performance        |"
echo "+------------------------------------------------------------------------+"

# add user
add_user()
{
  # add wh && set sudo
  useradd wh
  echo wh211212 | passwd --stdin wh
  mkdir -p /home/wh/script
  echo "wh  ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers
}

#check host && network
check_hosts()
{
    hostname=`hostname`
    if grep -Eqi '^127.0.0.1[[:space:]]*localhost' /etc/hosts; then
        echo "Hosts: ok."
    else
        echo "127.0.0.1 localhost.localdomain $hostname" >> /etc/hosts
    fi
    ping -c1 www.baidu.com
    if [ $? -eq 0 ] ; then
        echo "DNS...ok"
        echo "nameserver 114.114.114.114" >> /etc/resolv.conf
    else
        echo "DNS...fail"
        echo -e "nameserver 8.8.8.8\nameserver 114.114.114.114" > /etc/resolv.conf
    fi
}

repo_setup()
{
  # add repo && set yum cache
  # rpm -ivh http://mirrors.aliyun.com/epel/6/x86_64/epel-release-6-8.noarch.rpm
  #rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
  #yum -y install centos-release-scl-rh centos-release-scl
  yum -y install yum-plugin-priorities
  sed -i "s/keepcache=0/keepcache=1/g" /etc/yum.conf
}
#Set time zone synchronization

set_timezone()
{
    echo "Setting timezone..."
    rm -rf /etc/localtime
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

    #install ntp
    echo "[+] Installing ntp..."
    yum install ntpdate -y
    /usr/sbin/ntpdate pool.ntp.org
    echo '*/5 * * * * /usr/sbin/ntpdate pool.ntp.org > /dev/null 2>&1' > /var/spool/cron/root;chmod 600 /var/spool/cron/root
    /sbin/service crond restart
}

#update os
update(){
    yum -y update
# change yum source
#    cd /etc/yum.repos.d/
#    mkdir bak
#    mv ./*.repo bak
#    wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
#    wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-6.repo
#    yum clean all && yum makecache
    yum -y install wget vim openssh-clients iftop iotop sysstat lsof telnet traceroute htop gcc-c++ tree man iptraf lrzsz net-tools dstat tree ntp
    echo "yum update && yum install common command ......... succeed."
}

selinux()
{
       sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
       setenforce 0
       echo "disbale selinux ..................succeed."
}

#xen_hwcap_setting()
# {
#    if [ -s /etc/ld.so.conf.d/libc6-xen.conf ]; then
#        sed -i 's/hwcap 1 nosegneg/hwcap 0 nosegneg/g' /etc/ld.so.conf.d/libc6-xen.conf
#    fi
#}

#Modify file open number,define 1024
# /etc/security/limits.conf
limits_config()
{
cat >> /etc/security/limits.conf <<EOF
* soft nproc 65535
* hard nproc 65535
* soft nofile 8192
* hard nofile 8192
EOF
#ulimit -n 8192
#echo "ulimit -SHn 65535" >> /etc/rc.local
}

# ulimit -n 8192
#Shut off system service

stop_server()
{
     echo "stop not nessccery services!"
     for server in `chkconfig --list | grep 3:on | awk '{ print $1}'`
         do
           chkconfig --level 3 $server off
         done

     for server in crond network rsyslog sshd lvm2-monitor sysstat netfs blk-availability udev-post
         do
           chkconfig --level 3 $server on
         done
}

#define sshd
sshd_config(){
    #sed -i '/^#Port/s/#Port 22/Port 54077/g' /etc/ssh/sshd_config
    sed -i '/^#UseDNS/s/#UseDNS yes/UseDNS no/g' /etc/ssh/sshd_config
    #sed -i 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
    sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
    /etc/init.d/sshd restart
    echo "set sshd && restat sshd succedd!"
}

# iptables
iptables(){
   #disable iptables
   /etc/init.d/iptables stop
   chkconfig --level 3 iptables off
   #disable ipv6
   echo "alias net-pf-10 off" >> /etc/modprobe.d/modprobe.conf
   echo "options ipv6 disable=1" >> /etc/modprobe.d/modprobe.conf
   echo "NETWORKING_IPV6=off" >> /etc/sysconfig/network
   chkconfig --level 3 ip6tables off
   /etc/init.d/ip6tables stop
   echo "iptables is stop && ipv6 is disabled!"
}

other(){
# initdefault
sed -i 's/^id:.*$/id:3:initdefault:/' /etc/inittab
/sbin/init q
# PS1
#echo 'PS1="\[\e[37;40m\][\[\e[32;40m\]\u\[\e[37;40m\]@\h \[\e[35;40m\]\W\[\e[0m\]]\\$ \[\e[33;40m\]"' >> /etc/profile
echo "TMOUT=7200" >> /etc/profile
# Record command
sed -i 's/^HISTSIZE=.*$/HISTSIZE=1000/' /etc/profile
#echo "export PROMPT_COMMAND='{ msg=\$(history 1 | { read x y; echo \$y; });user=\$(whoami); echo \$(date \"+%Y-%m-%d %H:%M:%S\"):\$user:\`pwd\`/:\$msg ---- \$(who am i); } >> /tmp/\`hostname\`.\`whoami\`.history-timestamp'" >> /root/.bash_profile

# wrong password five times locked 180s

#sed -i '4a auth        required      pam_tally2.so deny=5 unlock_time=180' >> /etc/pam.d/system-auth
#sed -i 's#99999#180#' /etc/login.defs

# forbiden ctl-alt-delete
sed -i 's/exec \/sbin\/shutdown -r now \"Control-Alt-Delete pressed"/\#exec \/sbin\/shutdown -r now \"Control-Alt-Delete pressed"/g' /etc/init/control-alt-delete.conf

source /etc/profile
}

#
delete_user()
{
# delete no use user
echo "delete not use user"
echo ""
#for user in adm lp sync shutdown halt uucp operator gopher ;do userdel $user ; done
for user in adm lp sync shutdown halt uucp operator gopher
do userdel $user ; done
}

vim_setup()
{
cat > ~/.vimrc << EOF
" use extended function of vim (no compatible with vi)
set nocompatible
" specify encoding
set encoding=utf-8
" specify file encoding
set fileencodings=iso-2022-jp,sjis
" specify file formats
set fileformats=unix,dos
" take backup
" if not, specify [ set nobackup ]
" set backup
" specify backup directory
" set backupdir=~/backup
" take 50 search histories
set history=50
" ignore Case
set ignorecase
" distinct Capital if you mix it in search words
set smartcase
" highlights matched words
" if not, specify [ set nohlsearch ]
set hlsearch
" use incremental search
" if not, specify [ set noincsearch ]
set incsearch
" show line number
" if not, specify [ set nonumber ]
" set number
" Visualize break ( $ ) or tab ( ^I )
" set list
" highlights parentheses
" set showmatch
" show color display
" if not, specify [ syntax off ]
syntax on
" change colors for comments if it's set [ syntax on ]
highlight Comment ctermfg=LightCyan
" wrap lines
" if not, specify [ set nowrap ]
set wrap
EOF

}

#
sysctl_add(){
cat >> /etc/sysctl.conf << EOF
# appends
net.ipv4.tcp_synack_retries = 0
net.ipv4.tcp_max_syn_backlog = 20480
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 10
fs.file-max = 819200
net.core.somaxconn = 65536
net.core.rmem_max = 1024123000
net.core.wmem_max = 16777216
net.core.netdev_max_backlog = 165536
net.ipv4.ip_local_port_range = 10000 65535
EOF
# set kernel parameters work
sysctl -p
}

#main function
main(){
    add_user
    repo_setup
    check_hosts
    set_timezone
    selinux
    update
    limits_config
    stop_server
    sshd_config
    iptables
    other
    delete_user
#    sysctl_add
}
# execute main functions
main

echo "+------------------------------------------------------------------------+"
echo "|            To initialization system all completed !!!                  |"
echo "+------------------------------------------------------------------------+"
