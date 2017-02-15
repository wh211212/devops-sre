#!/bin/sh
# 
#get os information
#
 
function get_os_info() { 
    release=`cat /etc/redhat-release | awk '{print $1"_"$3}'`
    kname=`uname -s`
    nodename=`uname -n`
    kernal=`uname -r`
    bit=`uname -i`
    printf "OS_RELEASE: $release"_"$bit\n"
    printf "OS_DETAIL: $kname $nodename $kernal $bit\n"
}
 
get_os_info
 
#get vendor, model, sn...
 
function motherboard() { 
    vendor=`dmidecode -t 1 | grep "Manufacturer" | awk '{print $2}'`
    model=`dmidecode -t 1 | grep "Product" | awk '{print $4}'`
    sn=`dmidecode -t 1|grep "Serial" |awk '{print $3}'`
    printf "MODEL: $vendor $model\n"
    printf "SN: $sn\n"
}
 
motherboard
 
function memory() {
    count=`dmidecode  -q -t 17 2 |grep  "Size" |grep -v "No Module Installed"|awk '{print $2}'|uniq -c|awk '{print $1}'`
    capacity=`dmidecode  -q -t 17 2 |grep  "Size" |grep -v "No Module Installed"|awk '{print $2}'|uniq -c|awk '{print $2}'`
    capacity=`expr $capacity / 1024`
    printf "MEM: $count"*"$capacity"G"\n"
}
 
memory
 
function cpuinfo() {
    cpu_model=`cat /proc/cpuinfo|grep "model name"|head -1|awk -F: '{print $2}'`
    cpu_count=`cat /proc/cpuinfo|grep "core id"|grep "0"|uniq -c|awk '{print $1}'`
    cpu_total_cores=`cat /proc/cpuinfo|grep "processor"|wc -l`
    single_cores=`expr $cpu_total_cores / $cpu_count`
    printf "CPU:$cpu_model($cpu_count"*"$single_cores"Cores")\n"
}
 
cpuinfo
 
function diskinfo() {
    raidlevel=`/opt/MegaRAID/MegaCli/MegaCli64 -LDInfo -Lall -aALL |grep "RAID"|awk '{print $3}'|cut -b 9-9`
    disknumber=`/opt/MegaRAID/MegaCli/MegaCli64 -LDInfo -Lall -aALL | grep "Drives"|awk -F ":" '{print $2}'`
    disktype=`/opt/MegaRAID/MegaCli/MegaCli64 -PDList -aALL | grep "PD Type"|head -1|awk -F: '{print $2}'`
    diskcapacity=`/opt/MegaRAID/MegaCli/MegaCli64 -PDList -aALL | grep "Raw Size" | head -1 | awk '{print $3}'`
    printf "DISK: $disknumber"*"$diskcapacity"GB"$disktype (Raid Level: $raidlevel)\n"
}

diskinfo
