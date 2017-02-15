
#!/bin/bash
#name: intruder_detect.sh
#
authlog=/var/log/secure

if [[ -n $1 ]];
	then
	authlog=$1
	echo Using Log file : $authlog
fi

Log=/tmp/valid.$$.log
grep -v "Invalid" $authlog > $Log

users=$( grep "Failed password" $Log | awk '{print $(NF-5)} | sort | uniq )

printf "%-5s|%-10s|%-10s|%-12s|%-21s|%-33s|%s\n" "Sr#" "User" "Attempts" "IPaddress" "Host_Mapping" "Time range" 

ucount=0;

ip_list="$(egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" $Log | sort | uniq )"

for ip in $ip_list;

do
  grep $ip $Log > /tmp/temp.$$.log

for ip in $users;
       do
	grep $user /tmp/temp.$$.log >/$$.log
	cut -c-16 /tmp/$$.log > $$.Time
	tstart=$(head -1 $$.time);
	start=$(date -d "tstart" "+%s");
	tend=$(tail -1 $$.time);
	end=$(date -d "$tend" "+%s")
	limit=$(($end - $start))

	if [ $limit -gt 120 ];
		then
		let ucount++;
		IP=$(egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" /tmp/$$.log | head -1);
	    Time_range="$start-->$tend"
	    Attempts=$(cat /tmp/$$.log | wc -l);
	    Host=$(host $ip | awk '{print $NF}')
	    printf "%-5s|%-10s|%-10s|%-12s|%-21s|%-33s|%s\n" "ucount" "$user"
	    "Attempts" "$ip" "$Host" "$Time_range";
	fi

	done
done

rm /tmp/valid.$$.log /tmp/$$.log $$.time /tmp/temp.$$.log 2> /dev/null
