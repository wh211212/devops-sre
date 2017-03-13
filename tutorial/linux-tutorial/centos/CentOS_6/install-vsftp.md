## install vsftp

yum -y install vsftpd

## config vsftpd.config

```
mv /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf_bak
grep -v "#" /etc/vsftpd/vsftpd.conf_bak > /etc/vsftpd/vsftpd.conf

#
cat /etc/vsftpd/vsftpd.conf
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
xferlog_std_format=YES
ascii_upload_enable=YES
ascii_download_enable=YES
chroot_local_user=YES
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd/chroot_list
ls_recurse_enable=YES
listen=YES

pam_service_name=vsftpd
userlist_enable=YES
tcp_wrappers=YES
local_root=/opt/public_ftp
use_localtime=YES
```

##
/etc/init.d/vsftpd start
chkconfig vsftpd on
