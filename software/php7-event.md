# php7下安装event扩展

> 有效安排I/O，时间和信号的扩展 使用可用于特定平台的最佳I/O通知机制的事件,是PHP基础设施的libevent端口。
> 下载地址：http://pecl.php.net/package/event

- 安装支持库libevent，需要编译高版本（这里以最新版本release-2.1.8-stable为例）

```
wget -c https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz -P /usr/local/src
cd /usr/local/src
tar -zxvf libevent-2.1.8-stable.tar.gz && cd libevent-2.1.8-stable
./configure --prefix=/usr/local/libevent-2.1.8
make && make install
```

- 安装event库（以event-2.3.0.tgz为例）

```
wget -c http://pecl.php.net/get/event-2.3.0.tgz -P /usr/local/src
cd /usr/local/src
tar -zxvf event-2.3.0.tgz && cd event-2.3.0
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config --with-event-libevent-dir=/usr/local/libevent-2.1.8/
make && make install
```

- 在php.ini添加下面配置

```
extension=event.so
```
> 重启php-fpm后，使用php -m | grep event 查看event库插件是否安装成功
