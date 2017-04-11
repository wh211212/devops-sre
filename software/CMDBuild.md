# CMDBuild介绍

- 官网：http://www.cmdbuild.org

> CMDBuild是信息技术部的ERP，CMDBuild是企业系统：Java服务器端Web GUI Ajax，基于SOA的Web服务。所有这些都重用最好的开源技术和遵循行业标准。

> CMDBuild是一个开源Web应用程序，用于建模和管理ICT部门控制的资产和服务，因此根据ITIL最佳实践，必要时处理相关的工作流程操作。配置数据库（CMDB）的管理意味着保持最新，并可用于其他进程，与正在使用的组件相关的数据库，它们的关系及其随时间的变化。使用CMDBuild，系统管理员可以构建和扩展自己的CMDB（因此是项目名称），根据公司需求对CMDB进行建模;管理模块允许您逐渐添加新类别的项目，新属性和新关系。您还可以定义过滤器，“视图”和访问权限限于每个类的行和列。 CMDBuild为ITIL最佳实践提供了完整的支持，这些实践已成为现在的“标准事实”，这是一个非专有的以过程为导向的标准的服务管理系统。通过集成的工作流引擎，您可以使用外部可视化编辑器创建新的工作流程，并根据配置的自动程序在CMDBuild应用程序中导入/执行它们。集成在管理模块用户界面中的任务管理器也可用。它允许管理CMDB上的不同操作（进程启动，电子邮件接收和发送，连接器执行）和数据控制（同步和异步事件）。根据他们的发现，它发送通知，启动工作流并执行脚本。 CMDBuild还包括一个开源报表引擎JasperReports，可以让您创建报表;您可以设计（使用外部编辑器），导入并在CMDBuild中运行自定义报告。然后可以定义一些由图表组成的仪表板，它们立即显示当前系统（KPI）中某些指标的情况。 CMDBuild集成了流行的开源文档管理系统Alfresco。您可以附加文档，图片和其他文件。此外，您可以使用GIS功能在地理位置图（外部地图服务）和/或办公计划（本地GeoServer）和BIM功能上对资产进行地理参考和显示，以查看3D模型（IFC格式）。该系统还包括SOAP和REST Web服务，以实现与SOA的互操作性解决方案。 CMDBuild包括两个名为Basic Connector和Advanced Connector的框架，它们能够通过SOAP webservice将CMDB中记录的信息与外部数据源进行同步，例如通过自动库存系统（如开源OCS库存）或通过虚拟化或监控系统。通过REST webservice，CMDBuild GUI框架允许在外部门户上发布能够与CMDB进行交互的自定义​​网页。还提供用于移动工具（智能手机和平板电脑）的用户界面。它被实现为多平台应用程序（iOS，Android），并通过REST webservice链接到CMDB。

- 下载地址

> http://www.cmdbuild.org/en/download
wget https://sourceforge.net/projects/cmdbuild/files/latest/download

- 硬件要求

> 最近一代CPU
> 内存最少4G更多
> 100G硬盘
> # 建议硬盘设置raid模式，CMDBuild系统数据建议每天备份，提供UPS供电

- 软件要求

> 操作系统：Linux（本文采用CentOS6.x）
> 数据库：大于PostgreSQL 9.0（最好PostgreSQL 9.3）
> Servlet Container/Web server: Tomcat8.x,设置URIEncoding="UTF-8"
> DMS（Document Management System）：Reference website: http://www.alfresco.com/
> Java函数库：CMDBuild requires JDK 1.8 Oracle. Reference website: http://www. oracle .com/
>
