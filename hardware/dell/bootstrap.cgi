#!/bin/sh
# vim:tw=0:et:sw=4:ts=4

#echo "the repository bootstrap is down for maintainance. Please check back in 1 hour."
#[ -n "$DEBUG" ] || exit 1

# The purpose of this script is to set up the Dell yum repositories on your 
# system. This script will also install the Dell GPG keys used to sign 
# Dell RPMS.

# these two variables are replaced by the perl script 
# with the actual server name and directory.
SERVER="http://linux.dell.com"
# mind the trailing slash here...
REPO_URL="/repo/hardware/latest/"
REPO_NAME="dell-system-update"

# these are 'eval'-ed to do var replacement later.
GPG_KEY[${#GPG_KEY[*]}]='${SERVER}${REPO_URL}public.key'
#GPG_KEY[${#GPG_KEY[*]}]='${SERVER}${REPO_URL}some.key'

##############################################################################
#  Should not need to edit anything below this point
##############################################################################

set -e
[ -z "$DEBUG" ] || set -x

get_dist_version(){
    local REL_RPM rpmq
    # let user override... unwise but necessary for testing
    ([ -z "$dist_base" ] && [ -z "$dist_ver" ] && [ -z "$dist" ]) || return 0
    dist_base=unknown
    dist_ver=
    rpmq='rpm --qf %{name}-%{version}-%{release}\n -q'
    if $rpmq --whatprovides redhat-release >/dev/null 2>&1; then
        REL_RPM=$($rpmq --whatprovides redhat-release 2>/dev/null | tail -n1)
        VER=$(rpm -q --qf "%{version}\n" $REL_RPM)
        REDHAT_RELEASE=$VER

        # RedHat: format is 3AS, 4AS, 5Desktop... strip off al alpha chars
        # Centos/SL: format is 4.1, 5.1, 5.2, ... strip off .X chars
        dist_base=el
        dist_ver=${VER%%[.a-zA-Z]*}

        if echo $REL_RPM | grep -q centos-release; then
            CENTOS_RELEASE=$VER
        elif echo $REL_RPM | grep -q sl-release; then
            # Scientific Linux (RHEL recompile)
            SCIENTIFIC_RELEASE=$VER
        elif echo $REL_RPM | grep -q fedora-release; then
            FEDORA_RELEASE=$(rpm --eval "%{fedora}")
            dist_base=f
        	dist_ver=${FEDORA_RELEASE}
        elif echo $REL_RPM | grep -q enterprise-linux; then
            # this is for Oracle Enterprise Linux (probably 4.x)
            ORACLE_RELEASE=$VER
        elif echo $REL_RPM | grep -q enterprise-release; then
            # this is for Oracle Enterprise Linux 5+
            ORACLE_RELEASE=$VER
        fi

    elif $rpmq --whatprovides sles-release >/dev/null 2>&1; then
        REL_RPM=$($rpmq --whatprovides sles-release 2>/dev/null | tail -n1)
        SLES_RELEASE=$(rpm -q --qf "%{version}\n" $REL_RPM)
		dist_base=sles
        # SLES 11 is 11.1, strip off .X chars
        dist_ver=${SLES_RELEASE%%[.a-zA-Z]*}

    elif $rpmq --whatprovides sled-release >/dev/null 2>&1; then
        REL_RPM=$($rpmq --whatprovides sled-release 2>/dev/null | tail -n1)
        SLES_RELEASE=$(rpm -q --qf "%{version}\n" $REL_RPM)
		dist_base=sles
        dist_ver=${SLES_RELEASE}

    # This comes after sles-release because sles also defines suse-release
    elif $rpmq --whatprovides suse-release >/dev/null 2>&1; then
        REL_RPM=$($rpmq --whatprovides suse-release 2>/dev/null | tail -n1)
        SUSE_RELEASE=$(rpm -q --qf "%{version}\n" $REL_RPM)
		dist_base=suse
        # SLES 11 is 11.1, strip off .X chars
        dist_ver=${SUSE_RELEASE%%[.a-zA-Z]*}
    fi

    dist=$dist_base$dist_ver
}

install_gpg_key() {
    eval GPG_KEY_URL=$1
    echo "Downloading GPG key: ${GPG_KEY_URL}"
    GPG_FN=$(mktemp /tmp/GPG-KEY-$$-XXXXXX)
    trap "rm -f $GPG_FN" EXIT HUP QUIT TERM
    wget -q -O ${GPG_FN} ${GPG_KEY_URL}
    email=$(gpg -v ${GPG_FN} 2>/dev/null  | grep 1024D | perl -p -i -e 's/.*<(.*)>/\1/')
    HAVE_KEY=0
    for key in $(rpm -qa | grep gpg-pubkey)
    do
        if rpm -qi $key | grep -q "^Summary.*$email"; then 
            HAVE_KEY=1; 
            break; 
        fi
    done
    if [ $HAVE_KEY = 1 ]; then
        i=$(( $i + 1 ))
        echo "    Key already exists in RPM, skipping"
        continue
    fi

    echo "    Importing key into RPM."
    rpm --import ${GPG_FN}
    if [ $? -ne 0 ]; then
        echo "GPG-KEY import failed."
        echo "   Either there was a problem downloading the key,"
        echo "   or you do not have sufficient permissions to import the key."
        exit 1
    fi
    rm -f $GPG_FN
    trap - EXIT HUP QUIT TERM
}


write_repo() {
    cat > $1 <<-EOF
		[${REPO_NAME}_independent]
		name=${REPO_NAME}_independent
		baseurl=${SERVER}${REPO_URL}os_independent/
		gpgcheck=1
		gpgkey=${SERVER}${REPO_URL}public.key
		enabled=1	
		exclude=dell-system-update*.$exclude_arch

		[${REPO_NAME}_dependent]
		name=${REPO_NAME}_dependent
		mirrorlist=${SERVER}${REPO_URL}mirrors.cgi?osname=${replace_dist}&basearch=$replace_basearch&native=1
		gpgcheck=1
		gpgkey=${SERVER}${REPO_URL}public.key
		enabled=1	
EOF
}

install_all_gpg_keys() {
    local i=0
    while [ $i -lt ${#GPG_KEY[*]} ]; do
        install_gpg_key ${GPG_KEY[$i]}
        i=$(( $i + 1 ))
    done
}


# sets $dist
get_dist_version

if [ "${dist}" = "unknown" ]; then
    echo "Unable to determine that you are running an OS I know about."
    echo "Handled OSs include Red Hat Enterprise Linux and CentOS,"
    echo "Fedora Core and Novell SuSE Linux Enterprise Server and OpenSUSE"
    exit 1
fi

basearch=$(uname -i)

REPO_FULL_URL=${SERVER}${REPO_URL}mirrors.cgi/osname=${dist}\&basearch=$basearch\&native=1
replace_basearch=$basearch
replace_dist=$dist

install_all_gpg_keys

case $dist in
    sles*|suse*)
        if [ -e /usr/bin/rug ]; then
            # rug deadlocks if called recursively
            rug sd $REPO_NAME ||:
            yes | rug sa -t ZYPP $REPO_FULL_URL $REPO_NAME
            rug subscribe $REPO_NAME
        elif [ -e /usr/bin/zypp ]; then
            zypp sa -t YUM $REPO_FULL_URL $REPO_NAME
	elif [ -e /usr/bin/zypper ]; then
            zypper rs ${REPO_NAME}_independent
            zypper rs ${REPO_NAME}_dependent
            zypper as -t YUM ${SERVER}${REPO_URL}os_independent ${REPO_NAME}_independent
            zypper as -t YUM ${REPO_FULL_URL}\&redirpath=/ ${REPO_NAME}_dependent
        fi
        ;;
    el[5-9]*|f[0-9]*)
        replace_basearch=\$basearch
        replace_dist=$dist_base\$releasever
    	if [ "$basearch" == "x86_64" ]; then
		exclude_arch=i386
	else
		exclude_arch=x86_64
	fi
        echo "Write repository configuration"
        mkdir -p /etc/yum.repos.d ||:
        write_repo /etc/yum.repos.d/$REPO_NAME.repo
        ;;
esac

echo "Done!"
exit 0