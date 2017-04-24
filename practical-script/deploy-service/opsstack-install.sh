#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

error() {
    echo ""
    printf "${RED}  !! ${1}${NC}\n"
    echo ""
    printf "${RED}  !! Exiting...${NC}\n"
    exit 1
}

msg() {
    echo ""
    printf "${GREEN}  => ${1}${NC}\n"
}

msg_progress() {
    echo ""
    printf "${GREEN}  => ${1}${NC}   "
}

msg_okay() {
    printf "${GREEN} OK ${NC}\n"
}
msg_err() {
    printf "${RED} FAIL ${NC}\n"
}
msg_skip() {
    printf "${YELLOW} SKIP ${NC}\n"
}

# Check if running as root or with sudo
msg_progress "Checking permissions..."
if [[ ! `id -u` = 0 ]] ; then
    msg_err
    error "Execute with sudo!"
fi
msg_okay

# Check which Linux distribution and version
# and save them to variables
msg_progress "Checking platform..."
if [[ -f "/etc/redhat-release" ]] ; then
    # Apparently redhat, but which one?
    grep "CentOS" /etc/redhat-release > /dev/null 2>&1
    RES=$?
    if [[ ${RES} = 0 ]] ; then
        OS="CentOS"
        # And what is the version
        if [[ `cat /etc/redhat-release | awk '{print $3}'` == 6* ]] ; then
            OSVER="6"
        elif [[ `cat /etc/redhat-release | awk '{print $4}'` == 7* ]] ; then
            OSVER="7"
        else
            msg_err
            error "CentOS version not supported. Please refer to documentation."
        fi
    else
        OS="RHEL"
        # And what is the version
        if [[ `cat /etc/redhat-release | awk '{print $7}'` == 6* ]] ; then
            OSVER="6"
        elif [[ `cat /etc/redhat-release | awk '{print $7}'` == 7* ]] ; then
            OSVER="7"
        else
            msg_err
            error "Red Hat version not supported. Please refer to documentation."
        fi
    fi
elif [[ -f '/etc/system-release' ]] && [[ `cat /etc/system-release` == Amazon* ]] ; then
    # Definitely Amazon Linux then
    OS="Amazon Linux"
    # And what is the version
    if [[ `cat /etc/system-release | awk '{print $5}'` == 2016* ]] ; then
        OSVER="2016"
    elif [[ `cat /etc/redhat-release | awk '{print $3}'` == 2015* ]] ; then
        OSVER="2015"
    else
        msg_err
        error "Amazon Linux version not supported. Please refer to documentation."
    fi
elif [[ -f '/etc/debian_version' ]]; then
    # Apparently debian, but which one?
    command -V lsb_release > /dev/null 2>&1
    RES=$?
    if [[ ${RES} = 0 ]] ; then
        OS_DESC=`lsb_release -i | awk '{print $3}'`
        OS_RELEASE=`lsb_release -r | awk '{print $2}'`
        if [[ ${OS_DESC} == Ubuntu* ]]; then
            OS="Ubuntu"
            OSVER=${OS_RELEASE}
            if [[ ${OS_RELEASE} == 12.* ]]; then
                UBUNTU_OSVER="precise"
            elif [[ ${OS_RELEASE} == 14.* ]]; then
                UBUNTU_OSVER="trusty"
            elif [[ ${OS_RELEASE} == 16.* ]]; then
                UBUNTU_OSVER="xenial"
            else
                msg_err
                error "Ubuntu Linux version not supported. Please refer to documentation."
            fi
        elif [[ ${OS_DESC} == Debian* ]]; then
            OS="Debian"
            OSVER=${OS_RELEASE}
            if [[ ${OS_RELEASE} == 8.* ]]; then
                DEBIAN_OSVER="jessie"
            elif [[ ${OS_RELEASE} == 7.* ]]; then
                DEBIAN_OSVER="wheezy"
            else
                msg_err
                error "Unsupported Debian Version!"
            fi
        else
            msg_err
            error "Unsupported Debian Version!"
        fi
    else
        if [[ `cat /etc/debian_version` == [jsw]* ]]; then
            OS="Ubuntu"
            if [[ `cat /etc/debian_version` == wheezy* ]]; then
                OSVER="12"
                UBUNTU_OSVER="precise"
            elif [[ `cat /etc/debian_version` == jessie* ]]; then
                OSVER="14"
                UBUNTU_OSVER="trusty"
            elif [[ `cat /etc/debian_version` == stretch* ]]; then
                OSVER="16"
                UBUNTU_OSVER="xenial"
            else
                msg_err
                error "Ubuntu Linux version not supported. Please refer to documentation."
            fi
        elif [[ `cat /etc/debian_version` == [78].* ]]; then
            OS="Debian"
            OSVER=`cat /etc/debian_version`
            if [[ `cat /etc/debian_version` == 7.* ]]; then
                DEBIAN_OSVER="wheezy"
            elif [[ `cat /etc/debian_version` == 8.* ]]; then
                DEBIAN_OSVER="jessie"
            else
                msg_err
                error "Unsupported Debian Version!"
            fi
        else
            msg_err
            error "Unsupported Debian Version!"
        fi
    fi
else
    msg_err
    error "Unsupported Linux distribution!"
fi
msg_okay

# TODO: Check connection to opsstack and zabbix

# Show detected system information
msg "Detected $OS version $OSVER"

# Install repository
msg_progress "Adding repository..."
if [[ ${OS} == "CentOS" ]] || [[ ${OS} == "RHEL" ]] ; then
    REPO="http://repo.service.chinanetcloud.com/yum/el${OSVER}/base/x86_64/nc-repo-1.0.0-1.el${OSVER}.noarch.rpm"
    # Check if repo already installed
    rpm -qa | grep nc-repo  > /dev/null 2>&1
    RES=$?
    if [[ ${RES} = 0 ]] ; then
        yum reinstall ${REPO} -y > /dev/null 2>&1
        RES=$?
        if [[ ! ${RES} = 0 ]] ; then
            msg_err
            error "Error installing repository. Please refer to documentation."
        fi
    else
        yum install ${REPO} -y > /dev/null 2>&1
        RES=$?
        if [[ ! ${RES} = 0 ]] ; then
            msg_err
            error "Error installing repository. Please refer to documentation."
        fi
    fi
elif [[ ${OS} == "Amazon Linux" ]] ; then
    REPO="http://repo.service.chinanetcloud.com/yum/amzn/base/x86_64/nc-repo-1.0.0-1.amzn.noarch.rpm"
    # Check if repo already installed
    rpm -qa | grep nc-repo  > /dev/null 2>&1
    RES=$?
    if [[ ${RES} = 0 ]] ; then
        yum reinstall ${REPO} -y > /dev/null 2>&1
        RES=$?
        if [[ ! ${RES} = 0 ]] ; then
            msg_err
            error "Error installing repository. Please refer to documentation."
        fi
    else
        yum install ${REPO} -y > /dev/null 2>&1
        RES=$?
        if [[ ! ${RES} = 0 ]] ; then
            msg_err
            error "Error installing repository. Please refer to documentation."
        fi
    fi
elif [[ ${OS} == "Ubuntu" ]] ; then
    REPO="http://repo.service.chinanetcloud.com/apt/ubuntu/pool/${UBUNTU_OSVER}/main/nc-repo_1.0.0-1.ubuntu%2B${UBUNTU_OSVER}_all.deb"
    # Download repo package and install it
    wget -q ${REPO} -O /tmp/nc-repo_1.0.0-1.ubuntu.deb > /dev/null 2>&1
    RES=$?
    if [[ ! ${RES} = 0 ]] ; then
        msg_err
        error "Error downloading nc-repo package. Please refer to documentation."
    else
        dpkg -i /tmp/nc-repo_1.0.0-1.ubuntu.deb > /dev/null 2>&1
        RES=$?
        if [[ ! ${RES} = 0 ]] ; then
                msg_err
                error "Error installing repository. Please refer to documentation."
        fi
    fi
elif [[ ${OS} == "Debian" ]] ; then
    REPO="http://repo.service.chinanetcloud.com/apt/debian/pool/${DEBIAN_OSVER}/main/nc-repo_1.0.0-1.debian%2B${DEBIAN_OSVER}_all.deb"
    # Download repo package and install it
    wget -q ${REPO} -O /tmp/nc-repo_1.0.0-1.debian.deb > /dev/null 2>&1
    RES=$?
    if [[ ! ${RES} = 0 ]] ; then
        msg_err
        error "Error downloading nc-repo package. Please refer to documentation."
    else
        dpkg -i /tmp/nc-repo_1.0.0-1.debian.deb > /dev/null 2>&1
        RES=$?
        if [[ ! ${RES} = 0 ]] ; then
                msg_err
                error "Error installing repository. Please refer to documentation."
        fi
    fi
fi
msg_okay

# Install packages
msg_progress "Installing packages..."
if [[ ${OS} == "CentOS" ]] || [[ ${OS} == "RHEL" ]] || [[ ${OS} == "Amazon Linux" ]] ; then
    # Check if package already installed
    rpm -qa | grep opsstack-tools > /dev/null 2>&1
    RES=$?
    if [[ ${RES} = 0 ]] ; then
        yum reinstall opsstack-tools -y > /dev/null 2>&1
        RES=$?
        if [[ ! ${RES} = 0 ]] ; then
            msg_err
            error "Error installing packages. Please refer to documentation."
        fi
    else
        yum install opsstack-tools -y > /dev/null 2>&1
        RES=$?
        if [[ ! ${RES} = 0 ]] ; then
            msg_err
            error "Error installing packages. Please refer to documentation."
        fi
    fi
elif [[ ${OS} == "Ubuntu" ]] || [[ ${OS} == "Debian" ]]; then
    # Before installing package, update repository first
    apt-get update > /dev/null 2>&1
    # Check if package already installed
    dpkg -l |grep opsstack-tools > /dev/null 2>&1
    RES=$?
    if [[ ${RES} = 0 ]] ; then
        apt-get install --reinstall opsstack-tools -y > /dev/null 2>&1
        RES=$?
        if [[ ! ${RES} = 0 ]] ; then
            msg_err
            error "Error installing packages. Please refer to documentation."
        fi
    else
        apt-get install opsstack-tools -y > /dev/null 2>&1
        RES=$?
        if [[ ! ${RES} = 0 ]] ; then
            msg_err
            error "Error installing packages. Please refer to documentation."
        fi
    fi
fi
msg_okay

# Show information
msg "Everything was installed, executing opsstack-configure"
echo ""
echo ""
printf "${YELLOW}#############################################${NC}\n"
echo ""
echo ""

# Execute opsstack-configure
opsstack-configure
RES=$?

# Execute opsstack-install only if opsstack-configure exit with 0
if [[ ${RES} = 0 ]]; then
    opsstack-install
    RES=$?
fi

exit ${RES}
