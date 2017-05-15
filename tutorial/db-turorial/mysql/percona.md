# Percona监控和管理概述

> Percona监控和管理（PMM）是一个用于管理和监控MySQL和MongoDB性能的开源平台。 它由Percona与托管数据库服务，支持和咨询领域的专家合作开发。 PMM是一个免费的开源解决方案，您可以在自己的环境中运行，以实现最大的安全性和可靠性。 它为MySQL和MongoDB服务器提供全面的基于时间的分析，以确保您的数据尽可能高效地工作。

## Percona监控和管理架构

> PMM平台基于简单的客户端 - 服务器模型，可实现高效的可扩展性。它包括以下模块：

- PMM Client安装在您要监视的每个数据库主机上。它收集服务器指标，一般系统指标和查询分析数据，以获得完整的性能概述。收集的数据发送到PMM服务器。
- PMM Server是PMM的核心部分，它聚合收集的数据，并以Web界面的表格，仪表板和图形的形式呈现。

> PMM是旨在无缝协同工作的工具集合。一些是由Percona开发的，一些是第三方开源工具。

- 下图说明了PMM当前的结构：

![这里写图片描述](https://www.percona.com/doc/percona-monitoring-and-management/_images/pmm-diagram.png)


## PMM Client

> PMM客户端软件包适用于大多数流行的Linux发行版：
- Red Hat Enterprise Linux衍生产品的RPM（包括CentOS，Oracle Linux，Amazon Linux等）
- DEB用于基于Debian的发行版（包括Ubuntu等）

> PMM客户端软件包包含以下内容：

- pmm-admin是用于管理PMM客户端的命令行工具，例如，添加和删除要监视的数据库实例。
- percona-qan-agent是一种在收集查询性能数据时管理查询分析（QAN）代理的服务。它还与PMM服务器中的QAN API连接，并发送收集的数据。
- node_exporter是收集一般系统指标的Prometheus exporter。有关详细信息，请参阅https://github.com/prometheus/node_exporter。
- mysqld_exporter是收集MySQL服务器指标的Prometheus exporter。有关详细信息，请参阅https://github.com/percona/mysqld_exporter。
- mongodb_exporter是收集MongoDB服务器指标的Prometheus exporter。有关详细信息，请参阅https://github.com/percona/mongodb_exporter。
- proxysql_exporter是收集ProxySQL性能指标的Prometheus exporter。有关详细信息，请参阅https://github.com/percona/proxysql_exporter。

## PMM Server

>　PMM服务器将作为您的中央监控主机的机器运行。它通过以下方式作为设备分发：

- 可以用于运行容器的Docker映像
- 可以在VirtualBox或其他管理程序中运行
- 可以通过Amazon Web Services（AWS）运行的Amazon Machine Image（AMI）

> PMM服务器由以下工具组成：

- 查询分析（QAN）使您能够在一段时间内分析MySQL查询性能。除客户端QAN代理外，还包括以下内容：
  - QAN API是用于存储和访问在PMM客户端上运行的percona-qan-agent收集的查询数据的后端
  - QAN Web App是用于可视化收集的Query Analytics数据的Web应用程序。

- 度量监视器（MM）提供对MySQL或MongoDB服务器实例至关重要的度量的历史视图。它包括以下内容：
  - Prometheus是一个第三方时间序列数据库，连接到在PMM客户端上运行的出口商，并汇总了收集的指标.
  - Consul提供一个PMM客户端可以远程列出，添加和删除Prometheus主机的API。
  - Grafana是一个第三方仪表板和图形构建器，用于在直观的Web界面中可视化由Prometheus汇总的数据.
  - Percona仪表板是由Percona开发的Grafana仪表板
- Orchestrator是MySQL复制拓扑管理和可视化工具。

> 部署方案(https://www.percona.com/doc/percona-monitoring-and-management/architecture.html#id13)

> 参考：

[1]	https://prometheus.io/docs/introduction/overview/

[2]	https://www.consul.io/docs/

[3]	https://www.consul.io/docs/

[4]	https://github.com/outbrain/orchestrator/wiki/Orchestrator-Manual


## 部署Percona监控和管理

> 以下过程介绍如何正确部署PMM：

- 在主机上运行PMM Server，用于访问收集的数据，查看基于时间的图表，并执行性能分析。

  以下选项可用：
  - 使用Docker运行PMM服务器
  - 使用VirtualBox运行PMM服务器
  - 使用Amazon Machine Image（AMI）运行PMM服务器

### 安装运行PMM Server（使用Docker运行PMM服务器）

- 使用docker运行PMM Server

> PMM服务器的Docker映像公开托管在https://hub.docker.com/r/percona/pmm-server/。 如果要从Docker映像运行PMM Server，则主机必须能够运行Docker 1.13或更高版本，并具有网络访问权限。 有关使用Docker的更多信息，请参阅Docker文档(https://docs.docker.com/)。

- CentOS 6 安装Docker

```
yum --enablerepo=epel -y install docker-io
/etc/rc.d/init.d/docker start
chkconfig docker on
```
> 注：使用pmm-server映像时，请使用特定的版本标签，而不是最新的标签。目前的稳定版本是1.1.3。

#### 第一步. 创建一个PMM数据容器

- 要创建持久PMM数据的容器，请运行以下命令：

```
docker create \
   -v /opt/prometheus/data \
   -v /opt/consul-data \
   -v /var/lib/mysql \
   -v /var/lib/grafana \
   --name pmm-data \
   percona/pmm-server:1.1.3 /bin/true
```
- 此容器不运行，只需升级到较新的pmm服务器映像时，确保您保留所有PMM数据。不要删除或重新创建此容器，除非您打算清除所有PMM数据并重新开始。

#### 第二步、创建并运行PMM服务器容器

- 要运行PMM服务器，请使用以下命令：

```
docker run -d \
   -p 666:80 \
   --volumes-from pmm-data \
   --name pmm-server \
   --restart always \
   percona/pmm-server:1.1.3
```

> 注意：这里666端口是自定义的，因为笔者实验机80已被占用

#### 确认PMM 安装运行是否正确

> 通过使用运行容器的主机的IP地址连接到PMM Web界面来验证PMM服务器是否正在运行，然后在要监视的所有数据库主机上安装PMM Client
|Component|URL|
|-------  |---|
|PMM landing page|http://192.168.0.99:port|
|Query Analytics (QAN web app)|http://192.168.0.99/qan/|
|Metrics Monitor (Grafana)|http://192.168.0.99/graph/User name: admin Password: admin|
|Orchestrator|http://192.168.0.99/orchestrator|

### 删除PMM服务器

> 在停止和删除PMM服务器之前，请确保相关的PMM客户端不通过删除所有监视的实例来收集任何数据，如删除监控服务中所述。

```
docker stop pmm-server && docker rm pmm-server
docker rm pmm-data # 删除pmm数据容器
```
### 升级PMM服务器

```
docker stop pmm-server  # 先停
docker rm pmm-server    # 再删，如果如要保留收集数据，不要执行此操作
docker run -d \
   -p 999:80 \
   --volumes-from pmm-data \
   --name pmm-server \
   --restart always \
   --init \
   percona/pmm-server:1.1.3
```


# 在Red Hat和CentOS上安装PMM客户端

> PMM客户端是安装在您要监视的MySQL或MongoDB主机上的一组代理和出口商。 组件收集关于一般系统和数据库性能的各种数据，并将该数据发送到相应的PMM服务器组件。
> 注：不应该在具有相同主机名的数据库服务器上安装代理，因为PMM服务器使用主机名来标识收集的数据。

## 安装PMM客户端

> PMM客户端应该运行在任何现代的Linux发行版上，但是Percona提供的PMM客户端软件包只能从最受欢迎的Linux发行版的软件仓库进行自动安装：
- 系统事先无percona的yum源，需要新增

```
sudo yum install https://www.percona.com/redir/downloads/percona-release/redhat/latest/percona-release-0.1-4.noarch.rpm
```

- 安装pmm-client软件包

```
sudo yum install pmm-client -y
```

#### 将PMM客户端连接到PMM服务器

> 使用pmm-admin config --help，查看帮助

```
[root@backup-server ~]# sudo pmm-admin config --server 192.168.0.99:666
OK, PMM server is alive.

PMM Server      | 192.168.0.99:666
Client Name     | backup-server
Client Address  | 192.168.0.47
```

#### 开始数据收集

> 将客户端连接到PMM服务器后，通过添加监控服务，从数据库实例启用数据收集。
要启用一般系统度量，MySQL指标和查询分析，请运行：



#### 管理PMM客户端

```
# 添加监控服务
pmm-admin add
# 检查PMM客户端和PMM服务器之间的网络连接。
pmm-admin check-network
# 配置PMM Client如何与PMM服务器通信。
pmm-admin config
# 打印任何命令和退出的帮助
pmm-admin help
# 打印有关PMM客户端的信息
pmm-admin info
# 出为此PMM客户端添加的所有监控服务
pmm-admin list
# 检查PMM服务器是否存活
pmm-admin ping
# 检查PMM服务器是否存活。
pmm-admin purge
# 清除PMM服务器上的度量数据
pmm-admin remove, pmm-admin rm
# 删除监控服务
pmm-admin repair
# 重启pmm
pmm-admin restart
# 打印PMM Client使用的密码
pmm-admin show-passwords
# 开启监控服务
pmm-admin start
# 停止监控服务
pmm-admin stop
# 在卸载之前清理PMM Client
pmm-admin uninstall
```

- 添加MySQL查询分析服务

> 默认情况下不存在初始的被pmm-client使用的mysql用户，需要自己创建，笔者是登录到mysql中创建的用户，感兴趣的同学可以使用pmm-admin提供的参数创建默认用户

```
GRANT ALL PRIVILEGES ON *.* TO 'pmm'@'192.168.0.47' IDENTIFIED BY 'pmmpassword';
# 创建用户成功
[root@backup-server ~]# sudo pmm-admin add mysql:metrics --user pmm --password pmmpassword --host 192.168.0.47
# 使用创建的用户添加监控mysql服务
OK, now monitoring MySQL metrics using DSN pmm:***@tcp(192.168.0.47:3306)
[root@backup-server ~]# sudo pmm-admin add mysql:queries --user pmm --password pmmpassword --host 192.168.0.47
```

- 查看当前服务器监控的服务

```
[root@backup-server ~]# pmm-admin list
pmm-admin 1.1.3

PMM Server      | 192.168.0.99:666
Client Name     | backup-server
Client Address  | 192.168.0.47
Service Manager | unix-systemv

-------------- -------------- ----------- -------- ------------------------------- ------------------------------------------
SERVICE TYPE   NAME           LOCAL PORT  RUNNING  DATA SOURCE                     OPTIONS
-------------- -------------- ----------- -------- ------------------------------- ------------------------------------------
mysql:queries  backup-server  -           YES      pmm:***@tcp(192.168.0.47:3306)  query_source=slowlog, query_examples=true
linux:metrics  backup-server  42000       YES      -
mysql:metrics  backup-server  42002       YES      pmm:***@tcp(192.168.0.47:3306)  tablestats=OFF
```

#### 报错排查

> QAN API error: "qh.Profile: No query classes for selected instance and time range. Please check whether your MySQL settings match the recommended.".Check the /var/log/qan-api.log file in docker container for more information

```
# mysql 开启慢日志查询
yum install percona-toolkit -y  # 建议安装
#
slow_query_log = 1
long_query_time = 2
# 重启mysql(mysql5.6)
/etc/init.d/mysql restart
```

> 继续访问http://192.168.0.99:666，查看监控mysql的状态

![这里写图片描述](http://img.blog.csdn.net/20170515194213493?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

![这里写图片描述](http://img.blog.csdn.net/20170515194236727?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

![这里写图片描述](http://img.blog.csdn.net/20170515194325727?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvd2gyMTEyMTI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

> 后续补充监控MongoDB的教程。。。

- 参考链接：https://www.percona.com/software/database-tools/percona-monitoring-and-management
