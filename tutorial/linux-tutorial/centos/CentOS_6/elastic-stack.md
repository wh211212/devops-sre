# CentOS 6.x 安装Elastic stack 5.x

> https://www.elastic.co/guide/index.html
> https://www.elastic.co/guide/en/elastic-stack/current/installing-elastic-stack.html

## 安装顺序

> 官方建议按照下面顺序安装elastic stack

1.Elasticsearch
  - X-Pack for Elasticsearch

2.Kibana
  - X-Pack for Kibana

3.Logstash
4.Beats
5.Elasticsearch Hadoop
> 确保您的基础架构的正确部分在其他部分尝试使用之前正在运行

## 安装JDK

```
yum install java-1.8.0-openjdk -y
echo -e 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk.x86_64 \nexport CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar \nexport PATH=$PATH:$JAVA_HOME/bin' > >> /etc/profile
source /etc/profile
```

## 安装Elasticsearch

> 参考链接：https://www.elastic.co/guide/en/elasticsearch/reference/5.3/install-elasticsearch.html

### 使用rpm包安装Elasticsearch

- 导入Elasticsearch PGP密钥

```
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
```
- 从Elasticsearch源安装Elasticsearch

```
echo '[elasticsearch-5.x]
name=Elasticsearch repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
' | sudo tee /etc/yum.repos.d/elasticsearch.repo
```
- 使用以下命令，yum安装

```
sudo yum install elasticsearch
```

- 手动下载elasticsearch并安装RPM

```
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.3.0.rpm
sha1sum elasticsearch-5.3.0.rpm
sudo rpm --install elasticsearch-5.3.0.rpm
```
> 使用sha1sum或shasum生产的SHA与已发表的SHA相结合。
> https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.3.0.rpm.sha1

- 使用SysV init运行elasticsearch

```
sudo chkconfig --add elasticsearch
#
sudo -i service elasticsearch start
sudo -i service elasticsearch stop
```
- 检查Elasticsearch是否正在运行

```
curl -XGET 'localhost:9200/?pretty'
```

- 配置elasticsearch
> 参考：https://www.elastic.co/guide/en/elasticsearch/reference/5.3/settings.html

```
egrep -v "^#|^$" /etc/elasticsearch/elasticsearch.yml
```
> 重要的Elasticsearch配置

```
- path.data and path.logs
- cluster.name
- node.name
- bootstrap.memory_lock
- network.host
- discovery.zen.ping.unicast.hosts
- discovery.zen.minimum_master_nodes
```
---
> 官网配置如下：
  path:
    logs: /var/log/elasticsearch
    data: /var/data/elasticsearch
  cluster.name: logging-prod
  node.name: prod-elk-1 or ${HOSTNAME}
  bootstrap.memory_lock: true #禁用交换
  network.host: 192.168.0.51
  discovery.zen.ping.unicast.hosts:
   - 192.168.1.10:9300 # 指定端口
   - 192.168.1.11 # 不指定情况下默认为transport.profiles.default.port且会fallback to transport.tcp.port
   - seeds.mydomain.com # 可以是域名
  discovery.zen.minimum_master_nodes: 2 # 以三个主节点为例(master_eligible_nodes / 2) + 1
---
>　重要的系统设置

```
# Set JVM heap size
ES_JAVA_OPTS="-Xms2g -Xmx2g" ./bin/elasticsearch
# Disable swapping
export ES_JAVA_OPTS="$ES_JAVA_OPTS -Djava.io.tmpdir=/path/to/temp/dir" ./bin/elasticsearch
# Ensure sufficient virtual memory
sysctl -w vm.max_map_count=262144
# Ensure sufficient threads
/etc/security/limits.conf
elasticsearch  -  nofile  65536

```

## 安装Kibana

> 官网教程：https://www.elastic.co/guide/en/kibana/5.3/install.html

### 使用rpm包安装Kibana

- 使用新增的elasticsearch.repo安装kibana

```
sudo yum install kibana
```
- 手动下载kibana rpm进行安装

```
wget https://artifacts.elastic.co/downloads/kibana/kibana-5.3.0-x86_64.rpm
sha1sum kibana-5.3.0-x86_64.rpm # 将sha1sum或shasum生产的SHA与已发表的SHA进行比较
sudo rpm --install kibana-5.3.0-x86_64.rpm
```
- 设置kibana开机自启动

```
sudo chkconfig --add kibana
sudo -i service kibana start  # 启动kibana
sudo -i service kibana stop   # 停止kibana
```
> Kibana配置：https://www.elastic.co/guide/en/kibana/5.3/settings.html

### 安装Nginx反向代理Kibana

- 添加Nginx源

```
# https://www.nginx.com/resources/wiki/start/topics/tutorials/install/
echo '[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1
' | sudo tee /etc/yum.repos.d/nginx.repo
```
- 使用yum安装nginx和httpd-tools

```
yum install nginx httpd-tools -y
```
- 使用htpasswd创建一个名为“kibanaadmin”的管理员用户（可以使用其他名称），该用户可以访问Kibana Web界面

```
htpasswd -c /etc/nginx/htpasswd.users kibanaadmin
```

- 创建kibana的nginx host文件

```
[root@linuxprobe ~]# egrep -v "#|^$" /etc/nginx/conf.d/kibana.conf
server {
    listen       80;
    server_name  kibana.aniu.co;
    access_log  /var/log/nginx/kibana.aniu.co.access.log main;
    error_log   /var/log/nginx/kibana.aniu.co.access.log;
    auth_basic "Restricted Access";
    auth_basic_user_file /etc/nginx/htpasswd.users;
    location / {
        proxy_pass http://localhost:5601;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```
> 客户端访问kibana.aniu.co重定义到服务上http://localhost:5601（Kibana程序）

```
# 启动nginx并验证配置

sudo /etc/init.d/nginx start
sudo chkconfig nginx on
```
> SELinux已禁用。如果不是这样，需要运行以下命令使Kibana正常工作： sudo setsebool -P httpd_can_network_connect 1

- 浏览器访问kibana，确认kibana服务运行正常

### 连接Kibana与Elasticsearch



### 在生产环境中使用Kibana

> https://www.elastic.co/guide/en/kibana/5.3/production.html

## 安装X-Pack(for elastic-stack)

> 前提需安装对应版本的Elasticsearch和kibana

- 从elasticsearch集群中的每个节点上的ES_HOME运行bin / elasticsearch-plugin install：

```
cd /usr/share/elasticsearch
sudo bin/elasticsearch-plugin install x-pack # --batch跳过验证
```
- 手动下载X-Pack rpm包安装x-pack

```
https://artifacts.elastic.co/downloads/packs/x-pack/x-pack-5.3.0.zip
bin/elasticsearch-plugin install file:///path/to/file/x-pack-5.3.0.zip
```

- 确认您要授予X-Pack附加权限。 X-Pack需要这些权限才能在安装期间设置威胁上下文加载程序，以便Watcher可以发送电子邮件通知。
---
```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@     WARNING: plugin requires additional permissions     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
* java.lang.RuntimePermission accessClassInPackage.com.sun.activation.registries
* java.lang.RuntimePermission getClassLoader
* java.lang.RuntimePermission setContextClassLoader
* java.lang.RuntimePermission setFactory
* java.security.SecurityPermission createPolicy.JavaPolicy
* java.security.SecurityPermission getPolicy
* java.security.SecurityPermission putProviderProperty.BC
* java.security.SecurityPermission setPolicy
* java.util.PropertyPermission * read,write
* java.util.PropertyPermission sun.nio.ch.bugLevel write
* javax.net.ssl.SSLPermission setHostnameVerifier
See http://docs.oracle.com/javase/8/docs/technotes/guides/security/permissions.html
for descriptions of what these permissions allow and the associated risks.

Continue with installation? [y/N]y
```
- 如果您在Elasticsearch中禁用自动创建索引，请在elasticsearch.yml中配置action.auto_create_index以允许X-Pack创建以下索引：

```
action.auto_create_index: .security,.monitoring*,.watches,.triggered_watches,.watcher-history*
```

- 在kibana节点上安装X-Pack

```
bin/kibana-plugin install x-pack
/etc/init.d/kibana restart
```

- 在Logstash节点上安装X-Pack

```
bin/logstash-plugin install x-pack
/etc/init.d/kibana restart
```

### 启用和禁用X-Pack功能

> 默认情况下，所有X-Pack功能都被启用。您可以在elasticsearch.yml和kibana.yml中显式启用或禁用X-Pack功能：

| 設置                    |    說明                                               |
| :---------------------- | ----------------------------------------------------:|
| xpack.security.enabled  | 在elasticsearch.yml和kibana.yml中配置，设置为false     |
| xpack.monitoring.enabled| 在elasticsearch.yml和kibana.yml中配置，设置为false     |
| xpack.graph.enabled     | 在elasticsearch.yml和kibana.yml中配置，设置为false     |
| xpack.watcher.enabled   | 仅在kibana.yml中配置，设置为false                      |
| xpack.reporting.enabled | 仅在kibana.yml中配置，设置为false                      |

```
/usr/share/elasticsearch/bin/elasticsearch-plugin remove x-pack # 卸载x-pack
```

## 安装logstash

>　Logstash需要Java 8.不支持Java 9

- 使用elk-stack源安装

```
sudo yum install logstash
```

- logstash工作原理

> Logstash管道具有两个所需的元件，输入和输出，以及一个可选的元素，过滤。输入插件从源消耗数据，过滤器插件修改数据作为指定，输出的插件的数据写入一个目的地。

![Logstash-working-principle](https://www.elastic.co/guide/en/logstash/5.3/static/images/basic_logstash_pipeline.png)

- 要测试您的Logstash安装，运行最基本的Logstash管道

```
#
bin/logstash -e 'input { stdin { } } output { stdout {} }'
```

### 使用logstash解析日志

### 配置Filebeat发送日志行到Logstash
