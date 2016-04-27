#!/bin/sh
#
# Automatic/manual config of DRAC4 virtual UART and startup of DRAC4 Service
#
# chkconfig: 2345 20 80
# description: Configures/starts the host connection to the DRAC4 controller
# processname: racsvc
# config: /etc/sysconfig/racsvc.conf
#
### BEGIN INIT INFO
# Provides: racsvc
# Required-Start: $localfs $syslog
# Required-Stop: $localfs $syslog
# Default-Start: 2 3 4 5
# Default-Stop:
# Short-Description: Dell DRAC4 Service
# Description: Dell DRAC4 Service
### END INIT INFO

#RAC4 Check start

source /opt/dell/srvadmin/lib64/srvadmin-omilcore/Funcs.sh
SYSIDFILEPATH8G=`GetRegVal "/opt/dell/srvadmin/etc/omreg.cfg" "openmanage.8gsyslistfile"`
SYSID=`GetSysId`
if [ ${SYSID} != "023C" ]; then
TEST8G=`GetRegVal "${SYSIDFILEPATH8G}" "${SYSID}"`
[ -z "${TEST8G}" ] && exit 0
fi
#RAC4 Check end
# source common functions, if available
ENVTYPE=""
if [ -f /etc/init.d/functions ]; then
	. /etc/init.d/functions
	ENVTYPE="RHL"
elif [ -f /lib/lsb/init-functions ]; then
	. /lib/lsb/init-functions
	ENVTYPE="LSB"
fi

program=`basename $0`
service="racsvc"
cfgfile="/etc/sysconfig/${service}.conf"
svcpath="/opt/dell/srvadmin/sbin/${service}"
[ -z "$svcpath" ] && svcpath=${service}

LANG=C		# runs in 'C' locale
RETVAL=0

# source service configuration file, if available
[ -f ${cfgfile} ] && . ${cfgfile}

racsvc="Remote Access Controller (RAC4)"
racpci="1028:0012"
emsg=
norac="DRAC4 pci device not found"
notty="DRAC4 tty device not found"
xenerror="DRAC4 does not support Xen kernel"
maddr=
irqno=
ttyid=

function statmsg_success
{
	if [ ".$ENVTYPE" = ".RHL" ]; then
		success "$@" && echo
	elif [ ".$ENVTYPE" = ".LSB" ]; then
		log_success_msg "$@" 
	else
		echo -n $@ && echo -en \\033[45G && echo "OK"
	fi	
}

function statmsg_failure
{
	if [ ".$ENVTYPE" = ".RHL" ]; then
		failure "$@" && echo
	elif [ ".$ENVTYPE" = ".LSB" ]; then
		log_failure_msg "$@" 
	else
		echo -n $@ && echo -en \\033[45G && echo "FAILED"
	fi	
}

# probe for the DRAC4 pci device. if found, save DRAC4 IRQ and I/O ADDR.
function testrac
{
	uname -a | grep xen > /dev/null	
	[ $? -ne 1 ] && { emsg=${xenerror}; return 153; }
	which setserial >/dev/null 2>&1
	[ $? -ne 0 ] && { emsg="'setserial' not found"; return 151; }
	irqno=`lspci -d ${racpci} -v 2>/dev/null|grep "IRQ " 2>/dev/null`
	[ -z "${irqno}" ] && { emsg=${norac}; return 153; }
	irqno=${irqno##* }
	maddr=`lspci -d ${racpci} -v 2>/dev/null|grep "I/O " 2>/dev/null`
	[ -z "${maddr}" ] && { emsg=${norac}; return 153; }
	maddr=${maddr% [*}
	maddr=${maddr##* }
	uaddr=`echo ${maddr}|tr [a-f] [A-F]`
	laddr=`echo ${maddr}|tr [A-F] [a-f]`
	return 0
}

# find an available tty, or the one already in use by DRAC4
function get_ttyname
{
	# ensure that DRAC4 is present
	testrac || return $?

	# check whether the DRAC4 device is already in use by serial
	tag="port"
	sinfo="/proc/tty/driver/serial"
	hit=`cat ${sinfo}|grep -v unknown|grep "${tag}:[0]*${laddr}\|${tag}:[0]*${uaddr}"`

	if [ -n "$hit" ]; then
		ttyname="ttyS"`echo $hit|cut -f1 -d':'`
	else
		# DRAC4 port not yet in use; pick lowest available ttyno >= 2
		hit=99999
		shopt -s extglob
		for i in `ls /dev/ttyS+([[:digit:]])`
		{
			ttyno=${i#/dev/ttyS}
			if [ ${ttyno} -ge 2 -a ${ttyno} -lt $hit ]; then
				bzy=`cat ${sinfo} 2>/dev/null|grep -v unknown|grep "^${ttyno}:"`
				[ -z "${bzy}" ] && hit=${ttyno}
			fi
		}
		[ $hit -eq 99999 ] && { emsg=${notty}; return 152; }	# none found
		tag=
		ttyname="ttyS$hit"
	fi

	# check for pre-configured tty name
	if [ -n "$DRAC4_TTY" -a ! "$DRAC4_TTY" = "$ttyname" ]; then

		# tty for DRAC4 device is being changed, 'unset' prior tty
		[ -n "$tag" ] && setserial /dev/${ttyname} -z \
											uart unknown port 0x0 irq 0x0
		ttyname=${DRAC4_TTY}
	fi

	return 0
}

# start
function do_start
{
	if [ -n "${racbzy}" ]; then
		echo -n "${racsvc} Already started"
		RETVAL=0		# be nicer
	else
		get_ttyname
		RETVAL=$?
		if [ $RETVAL -ne 0 ]; then
			echo -n "DRAC4 probe: ${emsg}"
		else
			echo -n "Starting ${racsvc}... "
			if [ ! -c /dev/${ttyname} ]; then
				echo -n "invalid tty: '${ttyname}'"
				RETVAL=154
			fi
			
			# first clear the serial flags, etc. for the chosen DRAC4 tty.
			# without this, we may get screaming interrupts.
			setserial /dev/${ttyname} -z uart unknown port 0x0 irq 0x0
			
			# set serial characteristics for DRAC4 device
			# this depends on kernel version (due to serial rewrite in 2.6)
			kver=`uname -r|cut -d'.' -f1`
			krel=`uname -r|cut -d'.' -f2`
			knum=$((kver*100 + krel))
			if [ $knum -lt 206 ]; then # -- pre-2.6 kernel
				setserial /dev/${ttyname} \
					port 0x${maddr} irq ${irqno} ^skip_test autoconfig
				setserial /dev/${ttyname} \
					uart 16550A low_latency baud_base 1382400	\
					close_delay 0 closing_wait infinite
				stty -F /dev/${ttyname} crtscts raw
			else	# -- 2.6+ kernel
				setserial /dev/${ttyname} \
					port 0x${maddr} irq ${irqno} ^skip_test autoconfig
				setserial /dev/${ttyname} \
					uart 16550A low_latency baud_base 1382400	\
					close_delay 0 closing_wait infinite
				stty -F /dev/${ttyname} crtscts raw \
					-echo -echoctl -echoe -echok -echoke -echonl -echoprt
			fi

			# start the rac service
			${svcpfx}${ttyname} $RACSVC_OPTS >/dev/null 2>&1
			[ $? -ne 0 ] && RETVAL=158
		fi
	fi

	[ $RETVAL -eq 0 ] && touch /var/lock/subsys/$service
	[ $RETVAL -eq 0 ] && statmsg_success "$program $1" || statmsg_failure "$program $1"	
}

# stop
function do_stop
{
	echo -n "Stopping ${racsvc}: "
	if [ -z "$racbzy" ]; then
		svcpid=""
	else
		svcpid=`pidof -o$$ -o%PPID -o${racbzy} -x ${service}`
	fi
	if [ -z "$svcpid" ]; then
		echo -n "Not started"
		RETVAL=0
	else
		${svcpath} -s >/dev/null 2>&1
		[ $? -ne 0 ] && RETVAL=159 || RETVAL=0
	fi

	[ $RETVAL -eq 0 ] && rm /var/lock/subsys/$service 2> /dev/null
	[ $RETVAL -eq 0 ] && statmsg_success "$program $1" || statmsg_failure "$program $1"	
}

# status
function do_status
{
	echo -n "${racsvc} "
	if [ -z "$racbzy" ]; then
		svcpid=""
	else
		svcpid=`pidof -o$$ -o%PPID -o${racbzy} -x ${service}`
	fi
	if [ -n "$svcpid" ]; then
		echo -n "is running"
		RETVAL=0
                statmsg_success "$program $1"
	elif [ -f /var/lock/subsys/$service ]; then
		echo -n "stale lockfile exists "
		RETVAL=2
                statmsg_failure "$program $1"
	else
		echo -n "is stopped"
		RETVAL=3
                statmsg_success "$program $1"
	fi
}

function get_bzy
{
	# find out if service is running (get racsvc monitor pid)
	racbzy=`ps --no-headers -C${service} -o"pid ppid"|tr -s ' '|grep " 1$"`
	[ -n "$racbzy" ] && racbzy=${racbzy% *}
}

svcpfx="${svcpath} -d /dev/"
get_bzy

# handle request
case "$1" in
	statusreturnlsb)	# conforms with LSB
		RETVAL=0
		;;
	restart|force-reload)
		do_stop
		get_bzy
		do_start
		;;
	start)
  		do_start
		;;
	stop)
		do_stop
		;;
	status)
		do_status
		;;
	probe)
		echo -n "DRAC4 probe: "	&& testrac
		RETVAL=$?
		[ -n "${emsg}" ] && echo -n "${emsg} "
		[ $RETVAL -eq 0 ] && statmsg_success "$program $1" || statmsg_failure "$program $1"
		;;
	*)
		echo "Usage: ${service} {start|stop|restart|force-reload|status|probe}"
		RETVAL=2
esac

exit $RETVAL
