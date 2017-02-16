#!/bin/bash  
#--------------------------------------------------
#Date:June 15 2015
#Author:vdevops
#apt-get -y install dmidecode --force-yes or yum -y install dmidecode
#apt-get -y install pciutils --force-yes or yum -y install pciutils
#apt-get -y install curl --force-yes or yum -y install curl
#--------------------------------------------------
set -o nounset
line='======================================================================'
bluecolor='\E[1;32m'
 
if [[ `id -u` -ne 0 ]]
then
    echo "this script must be run as root!"
    exit 0
fi
 
function os ()
{
    manufacturer=$(dmidecode -s system-manufacturer)
    product=$(dmidecode -s system-product-name)
    sn=$(dmidecode -s system-serial-number)
    nu=$(dmidecode|grep "Height")
    kernel=$(uname -r)
    if [[ -e /etc/debian_version ]]
    then
        release1=$(cat /etc/debian_version)
        echo -e "${bluecolor}"Os:"Debian${release1}\n${line}"
    elif [[ -e /etc/redhat-release ]]
    then
        release2=$(cat /etc/redhat-release)
        echo -e "${bluecolor}"Os:"${release2}\n${line}"
    else
        echo "unkown release"
    fi
    if [[ -e /boot/grub/menu.lst ]]
    then
        grub1=$(cat /boot/grub/menu.lst|egrep -v "^#|^$")
        echo -e "Grub:${grub1}\n${line}"
    else
        grub2=$(cat /etc/default/grub|egrep -v "^#|^$")
        echo -e "Grub:${grub2}\n${line}"
    fi
    echo -e "Manufacturer:${manufacturer}"
    echo -e "Product:${product}"
    echo -e "Sn:${sn}"
    echo -e "U:${nu}\n${line}"
}
 
function cpu ()
{
    mode=$(getconf LONG_BIT)
    counts=$(cat /proc/cpuinfo|grep "physical id"|sort|uniq -c|wc -l)
    cores=$(grep 'cpu cores' /proc/cpuinfo|uniq|awk -F : '{print $2}' |sed 's/^[ \t]*//g')
    processor=$(cat /proc/cpuinfo|grep "processor"|wc -l)
    cpu=$(grep 'model name' /proc/cpuinfo|uniq|awk -F : '{print $2}' |sed 's/^[ \t]*//g' |sed 's/ \+/ /g')
    echo -e "Total Of Physical Cpu:${counts}"
    echo -e "Number Of Cpu Cores:${cores}"
    echo -e "Number Of Cpu Processor:${processor}"
    echo -e "Present Mode Of Cpu:${mode}"
    echo -e "Cpu Model:${cpu}\n${line}"
}
 
function mem ()
{
    swap=$(cat /proc/meminfo|grep SwapTotal|awk -F: '{print $2}'|awk -F" " '{print $1}')
    swap=$(expr $swap / 1024)
    mem=$(cat /proc/meminfo|grep MemTotal|awk -F: '{print $2}'|awk -F" " '{print $1}')
    memory=$(dmidecode|grep -i -C5 'Memory Device'|grep -v "No Module Installed"|grep -i size|grep -v "Range")
    memoryslot=$(dmidecode|grep -i -C5 'Memory Device'|grep "No Module Installed"|wc -l)
    mem=$(expr $mem / 1024)
    remem=$(free -m|grep cache|awk '/[0-9]/{ print $4" MB" }')
    echo -e "Memslot:${memoryslot}"
    echo -e "Number Of Mem:${memory}"
    echo -e "Total Of Mem:${mem}MB"
    echo -e "Total Of Swap:${swap}MB"
    echo -e "RemainMem:${remem}\n${line}"
}
 
function disk ()
{
    disk=$(fdisk -l|grep 'Disk'|awk -F , '{print $1}' | sed 's/Disk identifier.*//g' | sed '/^$/d')
    dftotal=$(df -h|grep "^/dev"|grep -v Filesystem)
    dfinode=$(df -i|grep "^/dev"|grep -v Filesystem)
    fstab=$(cat /etc/fstab|egrep -v "^#"'|media|proc'|awk '{print $1,$2,$3,$4}')
    blkid=$(blkid)
    echo -e "Disktotal:${disk}"
    echo -e "Dftotal:\n${dftotal}"
    echo -e "Dfinode:\n${dfinode}"
    echo -e "Fstab:\n${fstab}"
    echo -e "Blkid:\n${blkid}\n${line}"
}
 
function timezone ()
{
    if [[ -e /etc/timezone ]]
    then
        timezone1=$(cat /etc/timezone)
        echo -e "Timezone:${timezone1}\n${line}"
    else
        timezone2=$(cat /etc/sysconfig/clock|grep -v "^#"|grep -v "^$"|awk -F"=" '{print $2}')
        echo -e "Timezone:${timezone2}\n${line}"
    fi
}
 
function network ()
{
    hostnamecmd=$(cat /proc/sys/kernel/hostname)
    namecmd=$(cat /etc/resolv.conf|grep "nameserver"|egrep -v "^#|^$")
    innerip=$(hostname -I)
    outerip=$(curl -s ip.cip.cc)
    echo -e "Innerip:${innerip}"
    echo -e "Outerip:${outerip}"
    echo -e "${namecmd}"
    echo -e "Hostname:${hostnamecmd}\n${line}"
}
 
function ipmi ()
{
    lsmodipmi=$(lsmod|grep ipmi)
    if [[ $? -eq 0 ]]
    then
        ipmi=$(ipmitool lan print|grep "IP Address"|sed 's/IP Address Source.*//g'| sed '/^$/d')
        echo -e "Ipmi:${ipmi}"
    fi
    tty=$(ps aux|grep -w "ttyS1"|grep -v grep||ps aux|grep -w "ttyS0"|grep -v grep)
    if [[ $? -eq 0 ]]
    then
        echo -e "TtyS:${tty}\n${line}"
    fi
}
 
function processid ()
{
    ss -s|head -2
    net=`netstat -tpnl|grep LISTEN|awk '{print $4,$7}'`
    echo -e "Netstattpnl:\n${net}"
    processnum=`ss -pl|awk -F: '{print $4}'|awk -F"," '{print $2}'|sed '/^$/d'|wc -l`
    for ((i=1;i<=$processnum;i++))
    do
        pid=`ss -pl|awk -F: '{print $4}'|awk -F"," '{print $2}'|sed '/^$/d'|sed -n $i'p'`
        process=`pmap $pid|head -n 2`
        echo -e "Process:${process}"
    done
    echo -e ${line}
}
 
function swap ()
{
    echo -e "Pid\tSwap\tProgame"
    num=0
    for pid in `ls -1 /proc|egrep "^[0-9]"`
    do
        if [[ $pid -le '30' ]]
        then
            continue
        fi
        program=$(ps -eo pid,command|grep -w $pid|grep -v grep|awk '{print $2}')
        for swap in `grep Swap /proc/$pid/smaps 2>/dev/null|awk '{print $2}'`
        do
            let num=$num+$swap
        done
        echo -e "${pid}\t${num}\t${program}"
        num=0
    done|sort -nrk2|head
    echo -e ${line}
}
 
function mima ()
{
    num=$(cat /etc/passwd|grep "/bin/bash"|awk -F: '{print $1}'|wc -l)
    for ((i=1;i<=$num;i++))
    do
        user=$(cat /etc/passwd|grep "/bin/bash"|awk -F: '{print $1}'|sed -n $i'p')
        effeday=$(cat /etc/shadow|grep $user|awk -F: '{print $1,$5}')
        echo -e "Shadow:${effeday}"
    done
    if [[ -e /etc/sudoers ]]
    then
        sudoers=$(cat /etc/sudoers|egrep -v "^#|^$")
        echo -e "Sudoers:${sudoers}"
    fi
    chag=$(chage -l root)
    echo -e "ChageRoot:\n${chag}\n${line}"
}
 
function lastlogin ()
{
    if [[ -e /var/log/wtmp ]]
    then
        last=$(last|head -n 10)
        echo -e "Last:\n${last}\n${line}"
    fi
}
 
function limit ()
{
    limitcmd=$(cat /etc/security/limits.conf|egrep -v '^#|^$')
    if [[ $? -eq 0 ]]
    then
        echo -e "Limitconf:\n${limitcmd}\n${line}"
    fi
}
 
function diskcheck ()
{
if [[ -e /usr/local/sbin/MegaCli64 ]]
then
    cmd="/usr/local/sbin/MegaCli64"
    raid=`$cmd -cfgdsply -aALL|grep "RAID Level"|tail -1|awk -F: '{print $1"        :"$2}'`
    disknum=`$cmd -cfgdsply -aALL|grep "Number Of Drives"|awk -F: '{print $2}'`
    onlinedisk=`$cmd -cfgdsply -aALL|grep -c "Online"`
    faileddisk=`$cmd -AdpAllInfo -aALL -NoLog|awk '/Failed Disks/ {print $4}'`
    criticaldisk=`$cmd -AdpAllInfo -aALL -NoLog|awk '/Critical Disks/ {print $4}'`
    case "$raid" in
        "RAID Level        : Primary-1, Secondary-0, RAID Level Qualifier-0")
            echo "Raid Level:1";;
        "RAID Level        : Primary-0, Secondary-0, RAID Level Qualifier-0")
            echo "Raid Level:0";;
        "RAID Level        : Primary-5, Secondary-0, RAID Level Qualifier-3")
            echo "Raid Level:5";;
        "RAID Level        : Primary-6, Secondary-0, RAID Level Qualifier-3")
            echo "Raid Level:6";;
        "RAID Level        : Primary-1, Secondary-3, RAID Level Qualifier-0")
            echo "Raid Level:10";;
    esac
    echo "Total Diak Number:$disknum"
    echo "Online Disk Number:$onlinedisk"
    echo "Failed Disk Number:$faileddisk"
    echo "Critical Disk Number:$criticaldisk"
    $cmd -PDList -aALL|grep "Firmware state"
    echo -e ${line}
fi
}
 
function localea ()
{
    if [[ -e /etc/default/locale ]]
    then
        locale1=$(cat /etc/default/locale|egrep -v "^#|^$")
        echo -e "CurrLocale:${locale1}"
    elif [[ -e /etc/sysconfig/i18n ]]
    then
        locale2=$(cat /etc/sysconfig/i18n|egrep -v "^#|^$")
        echo -e "CurrLocale:${locale2}"
    else
        echo $LANG
    fi
    locale=`locale -a|wc -l`
    echo -e "LocaleNum:${locale}\n${line}"
}
 
function cron ()
{
    user=$(ps aux|grep -v USER|awk '{print $1}'|sort -r|uniq)
    echo -e "RunUser:\n${user}\n${line}"
    path1="/var/spool/cron/crontabs"
    path2="/var/spool/cron"
    if [[ -d $path1 ]]
    then
        for user in $(ls -1 $path1)
        do
            echo -e "$user:"
            crontab -l -u $user
        done
    else
        for user in $(ls -1 $path2)
        do
            echo -e "$user:"
            crontab -l -u $user
        done
    fi
}
 
os
cpu
mem
disk
timezone
network
ipmi
processid
swap
mima
lastlogin
limit
diskcheck
localea
cron
exit 0
