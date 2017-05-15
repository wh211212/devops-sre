# Percona监控和管理概述

> Percona监控和管理（PMM）是一个用于管理和监控MySQL和MongoDB性能的开源平台。 它由Percona与托管数据库服务，支持和咨询领域的专家合作开发。 PMM是一个免费的开源解决方案，您可以在自己的环境中运行，以实现最大的安全性和可靠性。 它为MySQL和MongoDB服务器提供全面的基于时间的分析，以确保您的数据尽可能高效地工作。

## Percona监控和管理架构

> PMM平台基于简单的客户端 - 服务器模型，可实现高效的可扩展性。它包括以下模块：

- PMM Client安装在您要监视的每个数据库主机上。它收集服务器指标，一般系统指标和查询分析数据，以获得完整的性能概述。收集的数据发送到PMM服务器。
- PMM Server是PMM的核心部分，它聚合收集的数据，并以Web界面的表格，仪表板和图形的形式呈现。

> PMM是旨在无缝协同工作的工具集合。一些是由Percona开发的，一些是第三方开源工具。

- 下图说明了PMM当前的结构：

[percona-diagram](https://www.percona.com/doc/percona-monitoring-and-management/_images/pmm-diagram.png)

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
   -p 80:80 \
   --volumes-from pmm-data \
   --name pmm-server \
   --restart always \
   --init \
   percona/pmm-server:1.1.3
```

#### 确认PMM 安装运行是否正确

> 通过使用运行容器的主机的IP地址连接到PMM Web界面来验证PMM服务器是否正在运行，然后在要监视的所有数据库主机上安装PMM Client
|Component|URL|
|-------  |---|
|PMM landing page|http://192.168.100.1:port|
|Query Analytics (QAN web app)|http://192.168.100.1/qan/|
|Metrics Monitor (Grafana)|http://192.168.100.1/graph/User name: admin Password: admin|
|Orchestrator|http://192.168.100.1/orchestrator|







# 在Red Hat和CentOS上安装PMM客户端

> 如果您正在运行基于RPM的Linux发行版，请使用yum软件包管理器从Percona官方软件仓库安装PMM Client。 Percona为64位版本的Red Hat Enterprise Linux 6（圣地亚哥）和7（Maipo）提供了.rpm包，其包括其完全二进制兼容性的衍生产品，如CentOS，Oracle Linux，Amazon Linux AMI等。

## 安装PMM 客户端

- 系统事先无percona的yum源，需要新增

```
sudo yum install https://www.percona.com/redir/downloads/percona-release/redhat/latest/percona-release-0.1-4.noarch.rpm
```

- 安装pmm-client软件包

```
sudo yum install pmm-client -y
```
