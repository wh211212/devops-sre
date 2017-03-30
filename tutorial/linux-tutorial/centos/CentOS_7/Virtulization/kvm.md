# kvm centos7

# br0
[root@kvm-centos7 network-scripts]# cat ifcfg-br0
TYPE="Bridge"
BOOTPROTO="static"
DEVICE="br0"
ONBOOT="yes"
IPADDR="192.168.1.159"
NETMASK="255.255.255.0"
#PREFIX="16"
GATEWAY="192.168.1.1"
DNS1="114.114.114.114"

# em1
[root@kvm-centos7 network-scripts]# cat ifcfg-enp2s0
TYPE="Ethernet"
NAME="enp2s0"
UUID="26e44c97-e5ba-4165-bf1e-6116cc8d0202"
BRIDGE="br0"
DEVICE="enp2s0"
ONBOOT="yes"

# package
yum -y install qemu-kvm libvirt virt-install bridge-utils
systemctl start libvirtd
systemctl enable libvirtd

# install guest

virt-install \
--name an-kvm-1 \
--ram 4096 \
--disk path=/var/kvm/images/an-kvm-1.img,size=50 \
--vcpus 2 \
--os-type linux \
--os-variant rhel7 \
--network bridge=br0 \
--graphics none \
--console pty,target_type=serial \
--location ''http://ftp.iij.ad.jp/pub/linux/centos/7/os/x86_64' \
--extra-args 'console=ttyS0,115200n8 serial'


virt-install \
--name centos7 \
--ram 4096 \
--disk path=/var/kvm/images/centos7.img,size=50 \
--vcpus 2 \
--os-type linux \
--os-variant rhel7 \
--network bridge=br0 \
--graphics none \
--console pty,target_type=serial \
--location 'https://mirrors.tuna.tsinghua.edu.cn/centos/7.3.1611/os/x86_64/' \
--extra-args 'console=ttyS0,115200n8 serial'

# use kvm

virt-install \
--name an-kvm-1 \
--ram 4096 \
--disk path=/var/kvm/images/an-kvm-1.img,size=30 \
--vcpus 2 \
--os-type linux \
--os-variant rhel7 \
--network bridge=br0 \
--graphics none \
--cdrom /media/CentOS-7-x86_64-Minimal-1611.iso


#
virt-install --paravirt --name demo --memory 500 --disk /var/kvm/images/demo.img,size=6 --graphics none --location   https://mirrors.tuna.tsinghua.edu.cn/centos/7.3.1611/os/x86_64/


virt-install \
--name centos7 \
--ram 4096 \
--disk path=/var/kvm/images/centos7.img,size=30 \
--vcpus 2 \
--os-type linux \
--os-variant rhel7 \
--network bridge=br0 \
--graphics none \
--console pty,target_type=serial \
--location 'https://mirrors.tuna.tsinghua.edu.cn/centos/7.3.1611/os/x86_64/' \
--extra-args 'console=ttyS0,115200n8 serial'
