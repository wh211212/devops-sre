#!/bin/bash
#functions: deploy ssh-keyscan
#
cd /root
cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys
for i in `cat ip.txt`
do
ip=$(echo "$i"|cut -f1 -d":")
password=$(echo "$i"|cut -f2 -d":")
 
expect -c "
spawn scp /root/.ssh/authorized_keys /root/remote_operate.sh  root@$ip:/tmp/
        expect {
                \"*yes/no*\" {send \"yes\r\"; exp_continue}
                \"*password*\" {send \"$password\r\"; exp_continue}
                \"*Password*\" {send \"$password\r\";}
               }
         "
expect -c "
spawn ssh root@$ip "/tmp/remote_operate.sh"
        expect {
                \"*yes/no*\" {send \"yes\r\"; exp_continue}
                \"*password*\" {send \"$password\r\"; exp_continue}
                \"*Password*\" {send \"$password\r\";}
               }
          "
done
============================================================
#ip.txt（前面是IP，后面是密码，用冒号：分割）
#192.168.1.148:anwg123.
#192.168.1.149:anwg123.
#192.168.1.150:anwg123.
============================================================
cat > /tmp/remote_operate.sh << EOF
#!/bin/bash
if [ ! -d /root/.ssh ];then 
mkdir /root/.ssh
fi
cp /tmp/authorized_keys /root/.ssh/
EOF
