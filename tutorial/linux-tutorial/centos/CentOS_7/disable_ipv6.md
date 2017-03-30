# 修改grub，让系统启动是不加载IPV6模块

```
[root@localhost ~]# cat /etc/default/grub
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="ipv6.disable=1 crashkernel=auto rd.lvm.lv=cl/root rd.lvm.lv=cl/swap rhgb quiet"
GRUB_DISABLE_RECOVERY="true"
```

- 重载grub

```
[root@localhost ~]# grub2-mkconfig -o /boot/grub2/grub.cfg
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-3.10.0-514.el7.x86_64
Found initrd image: /boot/initramfs-3.10.0-514.el7.x86_64.img
Found linux image: /boot/vmlinuz-0-rescue-e5273b17bf4d4645ab02c76e1cafcee9
Found initrd image: /boot/initramfs-0-rescue-e5273b17bf4d4645ab02c76e1cafcee9.img
done
```

验证IPV6是否关闭

1. 通过命令：

Check to see if you’re installation is currently set up for IPv6:

# cat /proc/sys/net/ipv6/conf/all/disable_ipv6

If the output is 0, IPv6 is enabled.
If the output is 1, IPv6 is already disabled.

需要特别说明的是：在这种方法下，使用# lsmod | grep ipv6依然会有一些相关模块列出。

2. 通过ifconfig查看网卡信息，以下打开和关闭ipv6的差别：


禁用IPV6的操作步骤
Step 1: add this rule in /etc/sysctl.conf : net.ipv6.conf.all.disable_ipv6=1

Step 2: add this rule in /etc/sysconfig/network: NETWORKING_IPV6=no

Step 3: add this setting for each nic X (X is the corresponding number for each nic) in /etc/sysconfig/network-scripts/ifcfg-ethX: IPV6INIT=no

Step 4: disable the ip6tables service : chkconfig ip6tables off

Step 5: Reload the sysctl configuration:

# sysctl -p
or
# reboot

注意：禁用IPV6后，可能会导致某些服务无法启动,比如VSFTP，对于VSFTP，需要修改/etc/vsftpd/vsftpd.conf文件中的listen和listen_ipv6两个选项：
listen=YES
listen_ipv6=NO
