#!/bin/bash
########################################################
#   check system user statys
#######################################################
# Changelog:
# 2016-05-27    wh      initial creation 
#######################################################
log=/var/log/wtmp

if [[ -n $1 ]];then
        log=$1
fi

printf "%-4s %-8s %-10s %-10s %-8s\n" "id" "User" "Start" "Logins" "Usage hours"

last -f $log | head -n -2 > /tmp/ulog.$$

cat /tmp/ulog.$$ | cut -d' ' -f1 | sort | uniq > /tmp/users.$$

(
while read user;
do
    grep ^$user /tmp/ulog.$$ > /tmp/user.$$
    cat /tmp/user.$$ | awk '{print $NF}' | tr -d ')(' > /tmp/time.$$
    seconds=0
        while read t
        do
                s=$(date -d $t +%s 2> /dev/null)
                let seconds=seconds+s
        done < /tmp/time.$$

    firstlog=$( tail -n 1 /tmp/user.$$ | awk '{ print $5,$6 }' )
    nlogins=$( cat /tmp/user.$$ | wc -l )
    hours=$( echo "$seconds / 60.0" | bc )
    printf "%-8s %-10s %-10s %-6s %-8s\n" $user "$firstlog" "$nlogins" "$hours"

done < /tmp/users.$$    

) | sort -nrk 4 | awk '{ printf("%-4s %s\n", NR, $0) }'

rm -rf /tmp/users.$$ /tmp/user.$$ /tmp/ulog.$$ /tmp/time.$$
