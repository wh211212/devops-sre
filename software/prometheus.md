# 使用Prometheus和Grafana绘制MySQL性能使用Prometheus和Grafana绘制MySQL性能使用Prometheus和Grafana绘制MySQL性能

## 简介
> Prometheus官网：https://prometheus.io/
> Prometheus是一个开源的服务监控系统，它通过HTTP协议从远程的机器收集数据并存储在本地的时序数据库上。它提供了一个简单的网页界面、一个功能强大的查询语言以及HTTP接口等等。Prometheus通过安装在远程机器上的exporter来收集监控数据，我们用到了以下两个exporter：

- node_exporter – 用于机器系统数据
- mysqld_exporter – 用于Mysql服务器数据

> Grafana是一个开源的功能丰富的数据可视化平台，通常用于时序数据的可视化。

- 安装使用参考：http://blog.csdn.net/wh211212/article/details/52735192

## 架构图

> 以下是我们将要使用的架构图：

[diagram-prometheus]()

## 安装和运行Prometheus
